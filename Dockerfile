FROM python:3.6-alpine

LABEL Organization="CTFHUB" Author="Virink <virink@outlook.com>"

COPY _files /tmp/
# COPY src /app

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
    apk update; \
    # _files
    mv /tmp/flag.sh /flag.sh; \
    mv /tmp/pip.conf /etc/pip.conf; \
    # pip && supervisor
    python -m pip install -U pip supervisor; \
    # python -m pip install -r /app/requirements.txt; \
    # supervisord_conf
    echo_supervisord_conf > /etc/supervisord.conf; \
    echo '[include]' >> /etc/supervisord.conf; \
    echo 'files = /etc/supervisor/conf.d/*.conf' >> /etc/supervisord.conf; \
    # supervisord.conf
    mkdir -p /etc/supervisor/conf.d; \
    mv /tmp/web.conf /etc/supervisor/conf.d/web.conf; \
    # docker-entrypoint
    mv /tmp/docker-entrypoint /usr/local/bin/docker-entrypoint \
    && chmod +x /usr/local/bin/docker-entrypoint; \
    # workdir
    mkdir /app && \
    chown -R nobody:nogroup /app

WORKDIR /app

EXPOSE 80

CMD ["docker-entrypoint"]
