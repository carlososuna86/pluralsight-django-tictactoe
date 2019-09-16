#!/bin/bash

ENVDIR="django-env"

if [[ ! -d ./$ENVDIR ]]; then
  echo "> Creating Virtual Environment"
  python3 -m venv $ENVDIR
fi

echo "> Activating the Virtual Environment"
. $ENVDIR/bin/activate

pip install --upgrade pip

pip install django

