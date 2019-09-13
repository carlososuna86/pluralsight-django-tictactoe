#!/bin/bash

virtual() {
  if [[ ! -d django-env ]]; then
    python3 -venv django-env
  fi

  . django-env/bin/activate
}

virtual

pip3 install --upgrade pip

if [[ ! -z $@ ]]; then
  $@
else
  python3 manage.py migrate
  python3 manage.py runserver 0.0.0.0:80
fi
