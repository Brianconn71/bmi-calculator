FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update && apt-get install -y nodejs npm curl

COPY BMICalculator/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY BMICalculator/ ./BMICalculator

COPY bmicalculator-frontend/ ./bmicalculator-frontend/

WORKDIR /app/bmicalculator-frontend
RUN npm install
RUN npm run build

WORKDIR /app/BMICalculator

RUN python manage.py collectstatic

# RUN python manage.py migrate

EXPOSE 8080

# CMD ["python", "manage.py", "runserver", "127.0.0.1:8080"]
CMD ["gunicorn", "--bind", "127.0.0.1:8080", "--chdir", "/app/BMICalculator",  "BMICalculator.wsgi:application"]