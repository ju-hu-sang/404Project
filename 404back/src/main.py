# src/main.py
"""FastAPI entrypoint"""
from fastapi import FastAPI
from api.pet import router as pet_router
from api.auth import router as auth_router
from api.user_info import router as user_router
from db.session import engine
from db.base import Base
from fastapi.staticfiles import StaticFiles
from pathlib import Path
from api import routine, pref  # __init__에 export돼있으면 OK

app = FastAPI(title="404 Back Pet Service API")


BASE_DIR = Path(__file__).resolve().parent.parent           
app.mount("/static", StaticFiles(directory=BASE_DIR / "static"), name="static")

# Router 등록 
app.include_router(auth_router)
app.include_router(user_router)
app.include_router(pet_router)  
app.include_router(pref.router)
app.include_router(routine.router)

# 테이블 자동 생성 (개발용) 
@app.on_event("startup")
def on_startup():
    print("▶ create_all called")
    print("▶ Engine URL =", engine.url)      # 맨 처음 import 되는 곳(모듈 맨 아래)에 임시로 추가
    Base.metadata.create_all(bind=engine,checkfirst=True)
    
# 진입체크 
@app.get("/")
async def health_check():
    return {"status": "ok"}

