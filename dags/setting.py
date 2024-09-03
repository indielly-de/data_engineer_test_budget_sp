from typing import Optional
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
   model_config = SettingsConfigDict(env_file='.env', env_file_encoding='utf-8')
   API_URL: str
   PROJECT_ID: str
   TABLE_ID: str
   PERIOD: str
   CURRENCY: str

settings = Settings()