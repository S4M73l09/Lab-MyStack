from flask import Flask
import os
import psycopg2

app = Flask(__name__)

@app.get("/")
def home():
    return {"message": "app-db compose running"}

@app.get("/health")
def health():
    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST", "db"),
            port=os.getenv("DB_PORT", "5432"),
            dbname=os.getenv("POSTGRES_DB", "practice_db"),
            user=os.getenv("POSTGRES_USER", "practice_user"),
            password=os.getenv("POSTGRES_PASSWORD", "practice_pass"),
        )
        conn.close()
        return {"status": "healthy", "database": "reachable"}
    except Exception as exc:
        return {"status": "unhealthy", "error": str(exc)}, 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)