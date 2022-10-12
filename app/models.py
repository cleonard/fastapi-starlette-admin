from datetime import datetime

from sqlalchemy import BigInteger, Boolean, Column, DateTime, String

from app.database import Base


class Task(Base):
    """User persistence"""

    __tablename__ = "tasks"

    id = Column(BigInteger, primary_key=True, index=True)
    title = Column(String)
    completed = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow())
    updated_at = Column(DateTime, default=datetime.utcnow(), onupdate=datetime.now())
