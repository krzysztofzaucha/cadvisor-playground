FROM grafana/grafana:master

USER root

RUN apk add mysql-client

ADD grafana/etc/grafana/grafana.ini /etc/grafana/grafana.ini
ADD grafana/conf/provisioning/datasources/prometheus.yaml /etc/grafana/provisioning/datasources/prometheus.yaml
ADD grafana/conf/defaults.ini /usr/share/grafana/conf/defaults.ini
ADD grafana/entrypoint.sh /entrypoint.sh

USER grafana

ENTRYPOINT /entrypoint.sh
