# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /python-docker

COPY Pipfile Pipfile
RUN pip3 install -r Pipfile

COPY . .

#EXPOSE 1212

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]

