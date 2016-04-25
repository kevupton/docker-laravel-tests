#!/usr/bin/env bash

mysql -e 'create database IF NOT EXISTS '$DB_DATABASE';' -uroot
mysql -e "grant all privileges on *.* to '$DB_USERNAME'@'localhost' with grant option;" -uroot

if [ ! -f "laravel/composer.json" ]; then
    rm -rf laravel
    composer create-project laravel/laravel
    cd laravel
    composer update
    composer require $PACKAGE_NAME
    if [[ -v PACKAGE_PROVIDER ]]; then
        echo "$(awk '/'\''providers'\''[^\n]*?\[/ { print; print "'$PACKAGE_PROVIDER',"; next }1' \
            config/app.php)" > config/app.php
        cat config/app.php
    fi
    if [[ -v SEED_CLASS ]]; then
        echo "$(cat database/seeds/DatabaseSeeder.php | \
            sed ':a;N;$!ba;s/\(public function run().*\?{\)/\1\n\t\$this->call('$SEED_CLASS');/g')" \
            > database/seeds/DatabaseSeeder.php
    fi
    php artisan vendor:publish
    cd ..
fi