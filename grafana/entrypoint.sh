#!/bin/sh -e

until mysql -h "${MYSQL_HOST}" -u"${MYSQL_USERNAME}" -p"${MYSQL_PASSWORD}" -P"${MYSQL_PORT}" "${MYSQL_NAME}"; do
  >&2 echo "waiting for MariaDB to be ready..."
  sleep 1
done

/run.sh
