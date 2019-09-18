#!/bin/bash

ROOT_DIR=$(pwd)

F_VERSION=0
F_INSTALL=0
F_BASH=0
F_SERVE=0
F_UWSGI=0

P_HOST=0.0.0.0
P_PORT=8000

parse_parameters() {
  if [[ -z $1 ]]; then
    F_SERVE=1
  fi

  while [[ $# -gt 0 ]]; do
    local param="$1"

    case $param in
      serve)
        F_SERVE=1
        ;;
      uwsgi)
        F_UWSGI=1
        ;;
      host)
        P_HOST="$2"
        shift
        ;;
      port)
        P_PORT="$2"
        shift
        ;;
      bash)
        F_BASH=1
        ;;
      version)
        F_VERSION=1
        ;;
      install)
        F_INSTALL=1
        ;;
      *)
        echo "Parameter $param unknown"
        ;;
    esac

    shift
  done
}

py_env() {
  local ENVDIR="django-env"

  if [[ ! -d ./$ENVDIR ]]; then
    echo "> Creating Virtual Environment"
    python3 -m venv $ENVDIR
  fi

  echo "> Activating the Virtual Environment"
  . $ENVDIR/bin/activate
}

py_unenv() {
  echo "> Deactivating the Virtual Enviroment"
  deactivate
}

py_install() {
  echo "> Installing packages"
  pip3 install --upgrade pip
  pip3 install -r requirements.txt
  # Also install pylint, to highlight code in the IDE
  pip3 install pylint
}

py_version() {
  echo "> python3 --version"
  python3 --version
  echo "> pip3 --version"
  pip3 --version
  echo "> pip3 freeze"
  pip3 freeze
}

py_wsgi() {
  # If running WSGI, skip Development Server
  F_SERVE=0

  local PROJ_DIR="./tictactoe"
  cd $PROJ_DIR
  echo "> Serving the application in WSGI Mode"
  uwsgi --socket "$1:$2" \
        --uid uwsgi \
        --plugins python3 \
        --protocol uwsgi \
        --wsgi main:application
  # print new line, to clear the ^C in the output
  echo ""
  cd $ROOT_DIR
}

py_serve() {
  local PROJ_DIR="./tictactoe"
  cd $PROJ_DIR
  echo "> Serving the application"
  python3 manage.py runserver $1:$2
  # print new line, to clear the ^C in the output
  echo ""
  cd $ROOT_DIR
}

py_bash() {
  echo "> Running bash in the Virtual Environment"
  bash
}

# ########################################################################### #
#                                Script Execution                             #
# ########################################################################### #
clear
parse_parameters $@
py_env

if [[ $F_INSTALL -eq 1 ]]; then
  py_install
fi
  
if [[ $F_VERSION -eq 1 ]]; then
  py_version
fi

if [[ $F_UWSGI -eq 1 ]]; then
  #py_wsgi $P_HOST $P_PORT
  echo "WSGI functionality disabled"
fi

if [[ $F_SERVE -eq 1 ]]; then
  py_serve $P_HOST $P_PORT
fi

if [[ $F_BASH -eq 1 ]]; then
  py_bash
fi

py_unenv
