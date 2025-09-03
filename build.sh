#!/bin/bash

# GuDestroyer Build Script
# Автор: Great Love

echo "🚀 GuDestroyer Build Script"
echo "=========================="

# Проверка наличия Theos
if [ -z "$THEOS" ]; then
    echo "❌ Ошибка: Theos не найден!"
    echo "Установите Theos: bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/theos/theos/master/bin/install-theos)\""
    exit 1
fi

echo "✅ Theos найден: $THEOS"

# Очистка предыдущих сборок
echo "🧹 Очистка предыдущих сборок..."
make clean

# Сборка проекта
echo "🔨 Сборка проекта..."
make

if [ $? -eq 0 ]; then
    echo "✅ Сборка успешна!"
else
    echo "❌ Ошибка сборки!"
    exit 1
fi

# Создание пакета
echo "📦 Создание пакета..."
make package

if [ $? -eq 0 ]; then
    echo "✅ Пакет создан успешно!"
    echo "📁 Пакет находится в: packages/"
else
    echo "❌ Ошибка создания пакета!"
    exit 1
fi

# Опциональная установка
read -p "📱 Установить на устройство? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📲 Установка на устройство..."
    make install
    
    if [ $? -eq 0 ]; then
        echo "✅ Установка успешна!"
        echo "🔄 Выполните респринг для активации твика"
    else
        echo "❌ Ошибка установки!"
        echo "💡 Убедитесь, что SSH доступ настроен правильно"
    fi
fi

echo "🎉 Готово!"
