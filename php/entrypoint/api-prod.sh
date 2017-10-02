#!/bin/bash

projectDir="/var/www"
artisanFile="/var/www/artisan"

if [ -f "$artisanFile" ];then
	cd $projectDir
	composer install --prefer-dist --no-scripts --no-dev
	chmod -R 775 $projectDir/storage;
	chmod -R 775 $projectDir/bootstrap/cache;
	php artisan migrate
	echo "[API] Runnning"
else
	echo "$artisanFile not found."
fi
cron -f
service cron start
php-fpm7.0
