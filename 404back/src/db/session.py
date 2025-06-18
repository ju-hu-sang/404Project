# src/db/session.py
"""
SQLAlchemy Engine ‧ SessionLocal ‧ get_db (FastAPI Depends)
"""
from typing import Generator
import os
from typing import Generator
from urllib.parse import quote_plus
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from dotenv import load_dotenv

load_dotenv()

# ────────────────── .env ──────────────────
user     = os.getenv("MYSQL_USER")
password = quote_plus(os.getenv("MYSQL_PW"))
host     = os.getenv("MYSQL_HOST")
port     = os.getenv("MYSQL_PORT")
database = os.getenv("MYSQL_DB")

if None in (user, password, database):
    raise RuntimeError("MYSQL 환경변수가 누락되었습니다 (.env 확인)")

SQL_URL = f"mysql+pymysql://{user}:{password}@{host}:{port}/{database}"
# ──────────────────────────────────────────

# ① Engine
engine = create_engine(
    SQL_URL,
    pool_pre_ping=True,
    echo=False,      # True 로 바꾸면 SQL 로그 출력
    future=True,
)

# ② Session factory
SessionLocal = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False,
    future=True,
)

# ③ FastAPI 의존성
def get_db() -> Generator[Session, None, None]:   # ✔ Session 을 제너릭에 명시
    db: Session = SessionLocal()                  # ✔ 타입 힌트도 Session
    try:
        yield db
    finally:
        db.close()