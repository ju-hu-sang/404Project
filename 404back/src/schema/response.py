# src/schema/response.py
"""응답용 Pydantic 모델"""
from pydantic import BaseModel, EmailStr, HttpUrl, Field
from datetime import datetime,date
from .request import GenderEnum

class UserSchema(BaseModel):
    id:       int
    username: str
    email:    EmailStr
    joined_at: datetime
    class Config:
        from_attributes = True  # SQLAlchemy ↔ Pydantic 매핑

class TokenSchema(BaseModel):
    access_token: str
    token_type:  str = "bearer"
    
class PetSchema(BaseModel):
    id: int
    pet_name: str
    pet_species: str
    age: int | None
    birth_date: date | None
    gender: GenderEnum | None
    weight: float | None
    image_path: str | None = Field(  
        default=None,
        description="이미지 파일 URL (예: /static/pets/xxx.jpg)"
    )
    created_at: datetime

    class Config:
        from_attributes = True
        populate_by_name = True   # alias 매핑용, 지금은없음
