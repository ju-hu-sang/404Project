# src/database/repository.py
"""Dataaccess layer  UserRepository"""
from __future__ import annotations
from fastapi import Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.orm import Session
from .orm import PetProfile, User
from .connection import get_db
from schema.request import PetCreateRequest, PetUpdateRequest

class UserRepository:
    """User 전용 Repository (CRUD + validation)"""

    def __init__(self, session: Session = Depends(get_db)):
        self.session = session

    #  조회 
    def get_by_username(self, username: str) -> User | None:
        return self.session.scalar(select(User).where(User.username == username))

    def get_by_email(self, email: str) -> User | None:
        return self.session.scalar(select(User).where(User.email == email))

    # 저장 
    def save(self, user: User) -> User:
        self.session.add(user)
        self.session.commit()
        self.session.refresh(user)
        return user

    #  중복 체크 
    def ensure_unique(self, *, username: str, email: str) -> None:
        if self.get_by_username(username):
            raise HTTPException(status_code=409, detail="이미 존재하는 사용자명입니다.")
        if self.get_by_email(email):
            raise HTTPException(status_code=409, detail="이미 사용 중인 이메일입니다.")
        
# 동물 등록란
class PetRepository:
    def __init__(self, session: Session = Depends(get_db)):
        self.session = session

    # CREATE
    def create(
        self,
        owner_id: int,
        data: PetCreateRequest,
        image_path: str | None,
    ) -> PetProfile:
        pet = PetProfile(
            owner_id=owner_id,
            **data.model_dump(),
            image_path=image_path,
        )
        self.session.add(pet)
        self.session.commit()
        self.session.refresh(pet)
        return pet

    # 25-05-21 추가 (반려한마리씩 조회)
    def get_by_id(self, owner_id: int, pet_id: int) -> PetProfile | None:
        return self.session.scalar(
            select(PetProfile)
            .where(PetProfile.id == pet_id, PetProfile.owner_id == owner_id)
        )
        
    def get_all(self, owner_id: int) -> list[PetProfile]:
        return self.session.scalars(
            select(PetProfile).where(PetProfile.owner_id == owner_id)
        ).all()

 # UPDATE 25-05-21 수정기능 추가
    def update(
        self,
        pet: PetProfile,               # 기존 엔티티
        data: PetUpdateRequest,        # 변경 내용
        new_photo: str | None = None,  # 새 이미지 url (선택)
    ) -> PetProfile:
        for field, value in data.model_dump(exclude_unset=True).items():  # unset:true => 요청에 안실려온필드는 안건듬(patch느낌낌)
            setattr(pet, field, value)
        if new_photo:
            pet.image_path = new_photo
        self.session.commit()
        self.session.refresh(pet)
        return pet

    # DELETE 25-05-21 삭제 기능 추가가
    def delete(self, pet: PetProfile) -> None:
        self.session.delete(pet)
        self.session.commit()