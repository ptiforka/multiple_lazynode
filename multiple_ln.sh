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




        rm -f ~/install.sh ~/update.sh ~/start.sh
        
        # Скачиваем клиент
        echo -e "${BLUE}Скачиваем клиент...${NC}"
        wget https://mdeck-download.s3.us-east-1.amazonaws.com/client/linux/install.sh
        source ./install.sh

        # Распаковываем архив
        echo -e "${BLUE}Обновляем...${NC}"
        wget https://mdeck-download.s3.us-east-1.amazonaws.com/client/linux/update.sh
        source ./update.sh

        # Переход в папку клиента
        cd
        cd multipleforlinux


        echo -e "${BLUE}Запускаем multiple-node...${NC}"
        wget https://mdeck-download.s3.us-east-1.amazonaws.com/client/linux/start.sh
        source ./start.sh

IDENTIFIER=$(cat ../account_id.txt)
PIN=$(cat ../pin.txt)


echo -e "${BLUE}Привязываем аккаунт с ID: $IDENTIFIER и PIN: $PIN...${NC}"
./multiple-cli bind --bandwidth-download 100 --identifier "$IDENTIFIER" --pin "$PIN" --storage 200 --bandwidth-upload 100


# Автоматически проверяем статус
sleep 2
./multiple-cli status
