#!/bin/bash

projectDir="/var/www"
artisanFile="/var/www/artisan"
envFile="/var/www/.env"

BITBUCKET_TEAM_NAME=$1
BITBUCKET_USERNAME=$2
BITBUCKET_PASSWORD=$3

cd $projectDir
echo "[API] Start entrypoint."

if [ -f "$artisanFile" ];then
	echo "[API] $artisanFile found!"
else
	echo "[API] Try clone pixelstairs-web-app-api project!"
	echo "[API] Please wait for clone project. for 5~10min"
	git clone https://$BITBUCKET_USERNAME:$BITBUCKET_PASSWORD@bitbucket.org/$BITBUCKET_TEAM_NAME/pixelstairs-web-app-api.git $projectDir
	echo "[API] Clone pixelstairs-web-app-api Done!"
	echo "[API] Check .env file with daniel!"
fi

if [ -f "$artisanFile" ];then
	composer install --prefer-dist
	chmod -R 777 $projectDir/storage;
	chmod -R 777 $projectDir/bootstrap/cache;

	if [ -f "$envFile" ];then
		echo "[API] .env file exists"
	else
		cp .env.example .env
		php artisan key:generate
	fi

	php artisan ide-helper:generate
	php artisan ide-helper:meta
	php artisan migrate
	echo "[API] Runnning"
else
	echo "[API] $artisanFile not found. Sorry.. Check your Bitbucket credential"
fi
service cron start
php-fpm7.0
