import os
import time
import redis

client = redis.Redis(
    host=os.getenv("REDIS_HOST", "redis"),
    port=int(os.getenv("REDIS_PORT", "6379")),
    password=os.getenv("REDIS_PASSWORD", "practice_redis_pass"),
    decode_responses=True,
)

while True:
    job = client.lpop("jobs")
    if job:
        print(f"Processed job: {job}", flush=True)
    else:
        time.sleep(2)