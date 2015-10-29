#!/bin/bash
set -e

#
# set localtime
ln -sf /usr/share/zoneinfo/$LOCALTIME /etc/localtime

#
# functions

function replace_vars() {
  eval "cat <<EOF
  $(<$1)
EOF
  " > $1
}

replace_vars '/etc/nginx/nginx.conf'

### pour les variables d'environnements de nginx contenant des valeurs de type variable "$__".
#if [ -n "$LOG_FORMAT" ]; then
#    sed -i "s/log_format.* /log_format main $LOG_FORMAT/" /etc/nginx/nginx.conf
#fi

#if [ -n "$FASTCGI_PARAM" ]; then
#    sed -i "s/fastcgi_param.* /fastcgi_param SCRIPT_FILENAME ${DOCUMENT_ROOT}$FASTCGI_PARAM/" /etc/nginx/nginx.conf
#fi
#main  '$remote_addr - $remote_user [$time_local] "$request" '
#                      '$status $body_bytes_sent "$http_referer" '
#                      '"$http_user_agent" "$http_x_forwarded_for"';
#
# Run
if [[ ! -z "$1" ]]; then
    exec ${*}
else
    exec nginx -g 'daemon off;'
fi