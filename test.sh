cd laravel
composer update
php artisan vendor:publish
php artisan migrate --seed
phpunit "vendor/$PACKAGE_NAME"