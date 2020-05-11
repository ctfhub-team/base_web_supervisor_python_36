# 基础镜像 WEB Supervisor python 3.6

- L: Linux Alpine
- S: Supervisor
- P: Python 3.6

## Usage

### ENV

- FLAG=ctfhub{supervisor_web}

You should rewrite flag.sh when you use this image.
The `$FLAG` is not mandatory, but i hope you use it!

### Files

- src 网站源码
    + app.py
    + requirements.txt
    + supervisor.conf -> /etc/supervisor/conf.d/*.conf
    + ...etc
- Dockerfile
- docker-compose.yml

### supervisor.conf [Default]

```conf
[program:web]
# Command
command=python /app/app.py
directory=/app
user=nobody
priority=1
# Restart
startsecs=3
startretries=3
autorestart=true
# Log
redirect_stderr=true
stdout_logfile=/tmp/supervisor.log
loglevel=info
```

### Dockerfile

```Dockerfile
FROM ctfhub/base_web_supervisor_python_36

COPY src /app
COPY _files/flag.sh /flag.sh

RUN python -m pip install -r /app/requirements.txt; \
    rm -f /app/requirements.txt; \
    # /etc/supervisor/conf.d/*.conf
    mv /app/supervisor.conf /etc/supervisor/conf.d/web.conf

```
