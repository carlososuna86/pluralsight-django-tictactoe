#!/bin/bash

virtual() {
  if [[ ! -d django-env ]]; then
    echo "> Creating a Virtual Environment"
    python3 -venv django-env
  fi

  echo "> Activating the Virtual Environment"
  . django-env/bin/activate
}

virtual

echo "> Installing packages"
pip install --upgrade pip
pip install django
pip install pylint

if [[ ! -z $@ ]]; then
  echo "> Running $@"
  $@
else
  echo "> Serving the application"
  cd tictactoe
  python3 manage.py migrate
  python3 manage.py runserver 0.0.0.0:80
  cd ..
fi

echo "> Deactivating the Virtual Environment"
deactivate
