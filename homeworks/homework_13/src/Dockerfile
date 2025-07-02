
FROM python:3.12-slim

#Workdir in the container
WORKDIR /app

#Copy requirements into container
COPY requirements.txt .

#Install requirements
RUN pip install --no-cache-dir -r requirements.txt

#Copy application into the container
COPY . .

#Port
EXPOSE 8000

#Run app on gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]

