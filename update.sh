cd /var/www/pterodactyl
php artisan down

curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv
chmod -R 755 storage/* bootstrap/cache

export COMPOSER_ALLOW_SUPERUSER=1
composer install --no-dev --optimize-autoloader --no-plugins

php artisan view:clear
php artisan config:clear
php artisan migrate --seed --force
chown -R nginx:nginx /var/www/pterodactyl/*

php artisan queue:restart
php artisan up

echo ""
echo "updated..."
echo ""