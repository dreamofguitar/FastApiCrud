# Dockerfile

# pull the official docker image
FROM python:3.9.4-slim

EXPOSE 8000
# set work directory
WORKDIR /app

RUN   apt-get update && apt-get install -y --no-install-recommends && apt-get install -y python3-dev build-essential \
        locales \
        tzdata \
        ca-certificates \
        libpq-dev \
        && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
        && echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
        && dpkg-reconfigure --frontend=noninteractive locales \
        && update-locale LANG=en_US.UTF-8 \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

# set env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
ADD requirements.txt .
RUN python -m pip install -r requirements.txt


WORKDIR /app
ADD . /app

RUN useradd appuser && chown -R appuser /app
USER appuser

CMD uvicorn main:app