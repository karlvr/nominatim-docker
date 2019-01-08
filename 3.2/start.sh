#!/bin/bash

stopServices() {
        service apache2 stop
        service postgresql stop
}
trap stopServices TERM

if [ -f /data/local.php ]; then
	cp /data/local.php /app/src/build/settings/local.php
fi

service postgresql start
service apache2 start

# fork a process and wait for it
tail -f /var/log/postgresql/postgresql-9.5-main.log &
wait
