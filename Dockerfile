FROM python:2-alpine

RUN apk add --no-cache --virtual .py-build \
        python-dev \
        py-pip \
        build-base 

RUN apk add --no-cache --virtual .deps \
        uwsgi \
        uwsgi-python \
        supervisor \
        libffi \
        libxml2 \
        libxslt \
        openssl

RUN apk add --no-cache --virtual .dev-deps \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        openssl-dev



COPY requirements.txt /

RUN pip install -r /requirements.txt

RUN apk del .py-build .dev-deps

WORKDIR /python-indieweb
COPY . /python-indieweb

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9998

#ENTRYPOINT ["python"]
#CMD ["indieweb.py", "--basepath", "/python-indieweb", "--logpath", "/dev/stdout", "--port", "9999", "--host","127.0.0.1", "--config", "/python-indieweb/indieweb.cfg"]
ENTRYPOINT ["sh", "/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/python-indieweb/supervisord.ini"]
