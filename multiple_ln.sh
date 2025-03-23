#!/bin/bash

# Цвета текста
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # Сброс цвета

# Проверка наличия curl и установка при необходимости
if ! command -v curl &> /dev/null; then
    sudo apt update
    sudo apt install curl -y
fi

echo -e "${BLUE}Устанавливаем ноду...${NC}"

# Обновление системы
sudo apt update && sudo apt upgrade -y

# Удаляем старые скрипты, если есть
rm -f ~/install.sh ~/update.sh ~/start.sh

# Скачиваем и запускаем скрипт установки
echo -e "${BLUE}Скачиваем клиент...${NC}"
wget https://mdeck-download.s3.us-east-1.amazonaws.com/client/linux/install.sh
source ./install.sh

# Скачиваем и запускаем скрипт обновления
echo -e "${BLUE}Обновляем...${NC}"
wget https://mdeck-download.s3.us-east-1.amazonaws.com/client/linux/update.sh
source ./update.sh

# Переход в директорию клиента
cd ~/multipleforlinux || exit

# Скачиваем и запускаем стартовый скрипт
echo -e "${BLUE}Запускаем multiple-node...${NC}"
wget https://mdeck-download.s3.us-east-1.amazonaws.com/client/linux/start.sh
source ./start.sh

# Считываем Account ID и PIN из файлов
IDENTIFIER=$(cat ../account_id.txt)
PIN=$(cat ../pin.txt)

# Привязка аккаунта
echo -e "${BLUE}Привязываем аккаунт с ID: $IDENTIFIER и PIN: $PIN...${NC}"
./multiple-cli bind --bandwidth-download 100 --identifier "$IDENTIFIER" --pin "$PIN" --storage 200 --bandwidth-upload 100

# Вывод команды проверки
echo -e "${PURPLE}-----------------------------------------------------------------------${NC}"
echo -e "${YELLOW}Команда для проверки статуса ноды:${NC}"
echo "cd ~/multipleforlinux && ./multiple-cli status"
echo -e "${PURPLE}-----------------------------------------------------------------------${NC}"
echo -e "${GREEN}CRYPTO FORTOCHKA — вся крипта в одном месте!${NC}"
echo -e "${CYAN}Наш Telegram https://t.me/cryptoforto${NC}"

# Автоматически проверяем статус
sleep 2
./multiple-cli status
