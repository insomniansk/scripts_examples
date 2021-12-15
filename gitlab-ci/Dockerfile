FROM gitlab.domain.com:5050/registration20/registration-2.0/djangoenv:1.3
WORKDIR /home/domain.com
COPY . .
EXPOSE 8000/tcp
CMD uwsgi --socket :8000 --module registration.wsgi
