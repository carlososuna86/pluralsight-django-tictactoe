FROM python:3.7

ENV PYTHONUNBUFFERED 1

RUN mkdir /usr/local/django
WORKDIR /usr/local/django

ENTRYPOINT [ "/usr/local/django/init.sh" ]

#COPY requirements.txt /usr/local/django/
#RUN pip install -r requirements.txt
