#!/usr/bin/env sh

HAPROXY="/usr/local/etc/haproxy"
HAPROXY_PIDFILE="/var/run/haproxy.pid"
HAPROXY_CFG="${HAPROXY}/haproxy.cfg"

/usr/local/sbin/haproxy -f "$HAPROXY_CFG" -p "$HAPROXY_PIDFILE" -D -sf $(cat $HAPROXY_PIDFILE)

exit 0
