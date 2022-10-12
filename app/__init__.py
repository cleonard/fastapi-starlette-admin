from fastapi import Depends, FastAPI
from pydantic import BaseModel
from sqlalchemy.orm import Session
from starlette_admin.contrib.sqla import Admin, ModelView

from app.database import get_db, engine
from app.models import Task

app = FastAPI()


class TaskSchema(BaseModel):
    title: str
    completed: bool = False

    def to_orm(self):
        return Task(title=self.title, completed=self.completed)


class TaskView(ModelView, model=Task):
    ...


@app.get("/")
async def get(db: Session = Depends(get_db)):
    tasks = db.query(Task).all()
    return {"tasks": tasks}


@app.post("/")
async def post(task: TaskSchema, db: Session = Depends(get_db)):
    task_record = task.to_orm()
    db.add(task_record)
    db.commit()
    return {"task": task}


admin = Admin(engine)
admin.add_view(TaskView)
admin.mount_to(app)
