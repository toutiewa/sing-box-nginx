
#!/bin/sh
set -e

sing-box run -c /etc/sing-box/config.json &
exec nginx -g 'daemon off;'
