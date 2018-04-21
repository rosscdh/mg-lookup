FROM python:3-alpine

RUN apk --update add \
    alpine-sdk libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev && \
    rm -rf /var/cache/apk/*

RUN pip install --upgrade pip==10.0.1

WORKDIR /srv/mg-lookup

ADD ./mg-lookup.py .
ADD ./requirements.txt .
ADD ./templates.yaml .
ADD ./docs .
ADD ./speech_assets .

RUN pip install -r requirements.txt

EXPOSE 5000

ENV FLASK_APP=mg-lookup.py

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]