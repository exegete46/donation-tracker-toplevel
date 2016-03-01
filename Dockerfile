FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -qqyf \
  ca-certificates \
  g++ \
  gcc \
  gettext \
  git \
  libmysqlclient-dev \
  libpq-dev \
  mysql-client \
  postgresql-client \
  python \
  python-pip \
  python-setuptools \
  sqlite3 \
  build-essential  \
  python-dev  \
  language-pack-en-base  \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/django-paypal
WORKDIR /tmp/django-paypal
RUN git clone https://github.com/GamesDoneQuick/django-paypal \
  /tmp/django-paypal \
  && git checkout gdqversion \
  && python setup.py install \
  && rm -Rf /tmp/django-paypal

ADD ./tracker/requirements.txt /tracker-requirements.txt
RUN pip install -r /tracker-requirements.txt \
  && rm -Rf /root/.cache/

WORKDIR /usr/src/app

ADD . /usr/src/app

CMD ["python", "manage.py", "runserver", "0.0.0.0:3000"]
