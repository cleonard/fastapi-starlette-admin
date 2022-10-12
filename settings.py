import os
from pathlib import Path

from dotenv import load_dotenv

BASE_DIR = Path(os.path.abspath(os.path.dirname(__file__)))

load_dotenv(BASE_DIR / ".env")

ENVIRONMENT = os.environ["ENVIRONMENT"]

DB_PROTOCOL = os.environ["DB_PROTOCOL"]
DB_USERNAME = os.environ["DB_USERNAME"]
DB_PASSWORD = os.environ["DB_PASSWORD"]
DB_HOST = os.environ["DB_HOST"]
DB_DATABASE = os.environ["DB_DATABASE"]

DATABASE_URL = (
    f"{DB_PROTOCOL}://{DB_USERNAME}:{DB_PASSWORD}@"
    f"{os.environ['DB_HOST']}/{os.environ['DB_DATABASE']}"
)
