- Python 3.10+
- PostgreSQL com extensão PostGIS
- Dependências Python: FastAPI, SQLAlchemy, GeoAlchemy2, psycopg2

Instale as dependências: `pip install -r requirements.txt`
Configure o banco de dados no arquivo `.env` ou variável `DATABASE_URL`.
Rode as migrações: `python migrate.py`
Execute a aplicação: `uvicorn main:app --reload`