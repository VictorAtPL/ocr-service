FROM python:3.7-slim

ENV PYTHONUNBUFFERED=1
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV FLASK_APP=app/api.py

RUN apt update && apt install -y tesseract-ocr wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/tesseract-ocr/tessdata_fast/raw/master/pol.traineddata -O /usr/share/tesseract-ocr/4.00/tessdata/pol.traineddata
COPY ./requirements.txt /code/requirements.txt

RUN pip install -r /code/requirements.txt

COPY . /code

WORKDIR /code

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
