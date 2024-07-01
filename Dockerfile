FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /APP

RUN apt-get update && apt-get install -y nodejs npm

COPY BMICalculator/BMICalculator/requirments.txt .
RUN pip install --no-cache-dir -r requirments.txt

COPY BMICalculator/ .

COPY bmicalculator-frontend/ ./bmicalculator-frontend/

WORKDIR /app/bmicalculator-frontend
RUN npm install
RUN npm run build

WORKDIR /app

RUN python manage.py collectstatiic --noinput

RUN python manage.py migrate

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "BMICalculator.wsgi:application"]