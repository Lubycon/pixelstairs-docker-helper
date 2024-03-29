#!/bin/bash

projectDir="/var/www"
artisanFile="/var/www/artisan"

if [ -f "$artisanFile" ];then
	cd $projectDir
	composer install --prefer-dist
	chmod -R 777 $projectDir/storage;
	chmod -R 777 $projectDir/bootstrap/cache;
	php artisan ide-helper:generate
	php artisan ide-helper:meta
	php artisan migrate
	echo "[API] Runnning"
else
	echo "$artisanFile not found."
fi
service cron start
php-fpm7.0
