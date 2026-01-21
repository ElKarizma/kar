FROM python:3.9-slim

WORKDIR /app

COPY . .

run pip install -r requirements.txt

CMD ["python", "app.py"]