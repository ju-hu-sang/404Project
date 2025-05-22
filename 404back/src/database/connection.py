#src/database/connection.py
"""SQLAlchemy Engine / Session utils"""
from __future__ import annotations
import os
from typing import Generator
from urllib.parse import quote_plus

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker

load_dotenv()

#  환경변수 
user = os.getenv("MYSQL_USER")
password_raw = os.getenv("MYSQL_PW")
host = os.getenv("MYSQL_HOST")
port = os.getenv("MYSQL_PORT")
database = os.getenv("MYSQL_DB")

if None in (user, password_raw, database):
    raise RuntimeError("MYSQL 환경변수가 누락되었습니다 (.env 확인)")

password = quote_plus(password_raw)  # 특수문자 인코딩

DATABASE_URL = f"mysql+pymysql://{user}:{password}@{host}:{port}/{database}"

#  Engine & SessionFactory 
_engine = create_engine(
    DATABASE_URL,
    pool_pre_ping=True,
    echo=False,  # SQL 로그 – 필요 시 True
    future=True, # SQLAlchemy 2.0 style
)

SessionFactory = sessionmaker(bind=_engine, autocommit=False, autoflush=False, future=True)

# Dependency 

def get_db() -> Generator[Session, None, None]:
    db = SessionFactory()
    try:
        yield db
    finally:
        db.close()