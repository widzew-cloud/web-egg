#!/bin/ash

mkdir -p /home/container/webroot

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

log_success() {
    echo -e "${GREEN}[Успех] $1${RESET}"
}

log_warning() {
    echo -e "${YELLOW}[Пред.] $1${RESET}"
}

log_error() {
    echo -e "${RED}[Ошибка] $1${RESET}"
}

echo "Удаление временных файлов..."
if rm -rf /home/container/tmp/*; then
    log_success "Удачно."
else
    log_error "Не удалось."
    exit 1
fi

echo "Запуск PHP..."
if /usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize; then
    log_success "Удачно."
else
    log_error "Не удалось."
    exit 1
fi

echo "Запуск вебсервера..."

log_success "Web server is running. All services started successfully."
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/

tail -f /dev/null
