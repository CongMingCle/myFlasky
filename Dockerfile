FROM python:3.6-alpine

ENV FLASK_APP flasky.py
ENV FLASK_CONFIG production

RUN adduser -D flasky
USER flasky

WORKDIR /home/flasky

COPY requirements requirements
RUN python -m venv venv

RUN venv/bin/pip install -r requirements/docker.txt -i https://mirrors.aliyun.com/pypi/simple/

COPY app app
COPY migrations migrations
COPY flasky.py config.py boot.sh ./
COPY .env .env-mysql ./

# run-time configuration
EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
