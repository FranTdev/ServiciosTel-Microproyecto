FROM python:3.10-slim

WORKDIR /app

# Instalar dependencias de sistema necesarias para mysqlclient
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copiar dependencias e instalarlas
COPY webapp/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código de la aplicación
COPY webapp /app

ENV FLASK_APP=run.py
EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]
