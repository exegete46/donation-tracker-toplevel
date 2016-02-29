FROM python:2

ENV LC_ALL en_US.UTF-8

RUN ["git", "clone", "https://github.com/GamesDoneQuick/django-paypal", "/tmp/django-paypal" ]
WORKDIR /tmp/django-paypal
RUN ["git", "checkout", "gdqversion"]
RUN ["python", "setup.py", "install"]
RUN mkdir -p /usr/src/app/db

ADD ./tracker/requirements.txt /tracker-requirements.txt
RUN ["pip", "install", "-r", "/tracker-requirements.txt"]

WORKDIR /usr/src/app

ADD . /usr/src/app

CMD ["python", "manage.py", "runserver", "0.0.0.0:3000"]
