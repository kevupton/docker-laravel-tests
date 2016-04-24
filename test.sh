cd laravel
composer update
php artisan vendor:publish --force
php artisan migrate --seed
phpunit "vendor/$PACKAGE_NAME"