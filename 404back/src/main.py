# src/main.py
"""FastAPI entrypoint"""
from fastapi import FastAPI, Depends
from api.pet import router as pet_router
from api.auth import router as auth_router
from api.user_info import router as user_router
from database.connection import _engine
from database.orm import Base, User
from security import get_current_user
from schema.response import UserSchema
from fastapi.staticfiles import StaticFiles

app = FastAPI(title="404 Back Pet Service API")

# Router 등록 
app.include_router(auth_router)
app.include_router(user_router)
app.include_router(pet_router)            
app.mount("/static", StaticFiles(directory="static"), name="static")  

# 테이블 자동 생성 (개발용) 
@app.on_event("startup")
def on_startup():
    print("▶ create_all called")
    print("▶ Engine URL =", _engine.url)      # 맨 처음 import 되는 곳(모듈 맨 아래)에 임시로 추가
    Base.metadata.create_all(bind=_engine,checkfirst=True)
    
# 진입체크 
@app.get("/")
async def health_check():
    return {"status": "ok"}

# @app.get("/users/me", response_model=UserSchema, tags=["Users"])
# async def read_users_me(current_user: User = Depends(get_current_user)):
#     return UserSchema.model_validate(current_user)