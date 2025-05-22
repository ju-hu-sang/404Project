# src/database/orm.py
"""SQLAlchemy ORM definitions (User & PetProfile).

SQLAlchemy ≥2.0에서는 **PEP‑484 타입 힌트**를 활용해 `Mapped[]` 제네릭을 명시해야 오류가 나지 않습니다.
"""
from __future__ import annotations
from sqlalchemy import Column, Integer, String, Float, Date,DateTime, ForeignKey, Enum as SQLEnum, func # func 추가 25-05-21
from sqlalchemy.orm import declarative_base, relationship, Mapped 
import enum
from datetime import datetime

Base = declarative_base()

class User(Base):
    """회원 기본 정보.
    `email`  로그인 ID (UNIQUE)
    `username`  화면에 노출될 별칭
    """
    __tablename__ = "user"

    id: Mapped[int] = Column(Integer, primary_key=True, index=True)
    username: Mapped[str] = Column(String(256), nullable=False, unique=True)
    email: Mapped[str] = Column(String(256), nullable=False, unique=True)
    password: Mapped[str] = Column(String(256), nullable=False)
    joined_at : Mapped[datetime] = Column(DateTime, default=datetime.utcnow, nullable=False)

    # 1:N 관계 – User ⟶ PetProfile
    pets: Mapped[list["PetProfile"]] = relationship(
        "PetProfile", back_populates="owner", cascade="all, delete-orphan"
    )

    @classmethod
    def create(cls, username: str, email: str, hashed_password: str) -> "User":
        return cls(username=username, email=email, password=hashed_password)

class GenderEnum(str, enum.Enum):
    male = "male"
    female = "female"

class PetProfile(Base):
    """반려동물 프로필 (User 1:N)."""

    __tablename__ = "pet_profile"

    id: Mapped[int] = Column(Integer, primary_key=True, index=True)
    owner_id: Mapped[int] = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False)
    pet_name: Mapped[str] = Column(String(100), nullable=False)
    pet_species: Mapped[str] = Column(String(100), nullable=False)
    age: Mapped[int | None] = Column(Integer, nullable=True)
    birth_date: Mapped[Date | None] = Column(Date, nullable=True)
    
    gender: Mapped[GenderEnum | None] = Column(SQLEnum(GenderEnum), nullable=True)
    weight: Mapped[float | None] = Column(Float, nullable=True)
    image_path: Mapped[str | None] = Column("image_path", String(512))
    
    created_at : Mapped[datetime] = Column(DateTime,server_default=func.now())  # 25-05-21 최초 생성시
    updated_at : Mapped[datetime] = Column(DateTime, onupdate=func.now()) # 25-05-21 수정시 자동 시간등록

    owner: Mapped["User"] = relationship("User", back_populates="pets")