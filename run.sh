#!/bin/bash


if [[ ! -d ./data ]]; then
  mkdir -p ./data/db
fi

docker-compose run web bash
# python3 -venv django-env
# . django-env/bin/activate
## pip install django==2.2.5

