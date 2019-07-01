#!/bin/sh

##
# exit if a command returns a non-zero exit code, print the commands and their # args as they are executed, exit if any unbound variables
#
set -e -x -u

##
# Run php-fpm
#
if [ "$APP_MODE" = "api" ]; then
	php-fpm -F
fi

##
# Run php-fpm
#
if [ "$APP_MODE" = "admin" ]; then
	php-fpm -F
fi

##
# Run laravel horizon
#
if [ "$APP_MODE" = "horizon" ]; then
		php /var/www/artisan horizon
fi

##
# Run a laravel queue worker
#
if [ "$APP_MODE" = "queue" ]; then
		php /var/www/artisan queue:work $QUEUE_CONNECTION
fi

##
# Run laravel websockets
#
if [ "$APP_MODE" = "websocket" ]; then
	 php /var/www/artisan websockets:serve
fi

##
# Configure a cron job to a run laravel jobs heartbeat every minute
#
if [ "$APP_MODE" = "job" ]; then
	 echo '*  *  *  *  * php /var/www/artisan schedule:run >> /dev/null 2>&1' | sudo tee -a /etc/crontabs/ambientum
 	 crond -f
fi

echo "Variable APP_MODE must be one of api, admin, horizon, queue, websocket, or job"
exit 1
