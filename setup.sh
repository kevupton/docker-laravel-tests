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
            config/app.php)" > config/app.php;
    fi
    if [[ -v SEED_CLASS ]]; then
        echo "$(awk '/public function run\(\).*?\{/ { print; print "$this->call('$SEED_CLASS');"; next }1' \
            database/seeds/DatabaseSeeder.php)" > database/seeds/DatabaseSeeder.php;
    fi
    php artisan vendor:publish
    php artisan migrate
    cd ..
fi