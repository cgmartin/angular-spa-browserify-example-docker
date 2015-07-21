#!/usr/bin/env sh

HAPROXY="/usr/local/etc/haproxy"
HAPROXY_PIDFILE="/var/run/haproxy.pid"
HAPROXY_CFG="${HAPROXY}/haproxy.cfg"
HAPROXY_CTMPL="/etc/consul-templates/haproxy.ctmpl"

CONSUL_TEMPLATE_CMD="/usr/local/bin/consul-template -consul=consul:8500"
eval $CONSUL_TEMPLATE_CMD \
      -template "${HAPROXY_CTMPL}:${HAPROXY_CFG}" \
      -once

cd "$HAPROXY"

/usr/local/sbin/haproxy -f "$HAPROXY_CFG" -p "$HAPROXY_PIDFILE" -D

eval $CONSUL_TEMPLATE_CMD \
      -template "${HAPROXY_CTMPL}:${HAPROXY_CFG}:/tmp/reload.sh"
