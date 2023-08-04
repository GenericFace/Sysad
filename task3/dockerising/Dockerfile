FROM python:3.9

WORKDIR /app

COPY requirements.txt /app
COPY server.py /app/server.py
RUN pip install -r requirements.txt

CMD ["tail","-f", "/dev/null"]
