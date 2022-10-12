"""Seed database with Task objects having random due dates"""

import random
import sys
from pathlib import Path

base_dir = Path("/vagrant")
sys.path.insert(0, str(base_dir))

from app.database import engine, SessionLocal  # noqa
from app.models import Base, Task  # noqa

sys.path.pop(0)

db = SessionLocal()
Base.metadata.create_all(bind=engine)

booleans = (True, False)
task_data = base_dir / "tasks.txt"

with open(task_data, "r") as buffer:
    task_names = buffer.read().splitlines()
    random.shuffle(task_names)

    for name in task_names:
        instance = Task(title=name, completed=random.choice(booleans),)
        db.add(instance)

    db.commit()

db.close()
