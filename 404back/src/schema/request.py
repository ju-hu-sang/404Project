# src/schema/request.py
"""요청용 Pydantic 모델"""
from pydantic import BaseModel, EmailStr, Field
from datetime import date
from fastapi import UploadFile, File
from typing import Annotated
from fastapi import Form
from enum import Enum


class GenderEnum(str, Enum):
    male = "male"
    female = "female"

class SignUpRequest(BaseModel):
    """회원 가입 요청"""
    username: str = Field(..., description="표시명/닉네임")
    email:    EmailStr
    password: str

class LogInRequest(BaseModel):
    """로그인 요청 email & password"""
    email:  EmailStr
    password: str

class CreateOTPRequest(BaseModel):
    email: EmailStr

class VerifyOTPRequest(BaseModel):
    email: EmailStr
    otp:   int
    
class PetCreateRequest(BaseModel):
    pet_name: str
    pet_species: str
    age: int | None = None
    birth_date: date | None = None
    gender: GenderEnum | None = None
    weight: float | None = None
       
    @classmethod
    def as_form(
        cls,
        pet_name: str       = Form(...),
        pet_species: str    = Form(...),
        age: int | None     = Form(None),
        birth_date: date | None = Form(None),
        gender: GenderEnum | None  = Form(None),
        weight: float | None = Form(None),
    ) -> "PetCreateRequest":
        return cls(
            pet_name=pet_name,
            pet_species=pet_species,
            age=age,
            birth_date=birth_date,
            gender=gender,
            weight=weight,
        )

class PetUpdateRequest(PetCreateRequest):
    pet_name:    str | None = None
    pet_species: str | None = None
    age:         int | None = None
    birth_date:  date | None = None
    gender:      GenderEnum | None = None      # 남/여
    weight:      float | None = None

    @classmethod
    def as_form(
        cls,
        pet_name:    str | None = Form(None),
        pet_species: str | None = Form(None),
        age:         int | None = Form(None),
        birth_date:  date | None = Form(None),
        gender:      GenderEnum | None = Form(None),
        weight:      float | None = Form(None),
    ):
        return cls(
            pet_name=pet_name,
            pet_species=pet_species,
            age=age,
            birth_date=birth_date,
            gender=gender,
            weight=weight,
        )
# ───── multipart/form-data 용 별도 Dependency ─────
PetPhoto = Annotated[UploadFile | None, File(None)]
