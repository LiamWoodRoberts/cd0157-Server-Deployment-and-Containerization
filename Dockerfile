FROM python:3.7.2-slim

RUN mkdir /app
WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONUNBUFFERED 1

COPY . .
CMD ["gunicorn", "-b", "0.0.0.0:8080", "main:APP"]