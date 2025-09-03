#!/bin/bash

# Скрипт для установки настроек GuDestroyer
# Автор: Great Love

echo "🔧 Установка настроек GuDestroyer"

# Создаем директории
echo "📁 Создание директорий..."
mkdir -p /Library/PreferenceBundles/GuDestroyerPrefs.bundle
mkdir -p /Library/PreferenceLoader/Preferences

# Копируем entry.plist
echo "📋 Копирование entry.plist..."
cp entry.plist /Library/PreferenceLoader/Preferences/

# Создаем простой Info.plist для bundle
echo "📄 Создание Info.plist..."
cat > /Library/PreferenceBundles/GuDestroyerPrefs.bundle/Info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>GuDestroyerPrefs</string>
    <key>CFBundleIdentifier</key>
    <string>com.greatlove.gudestroyer.prefs</string>
    <key>CFBundleName</key>
    <string>GuDestroyerPrefs</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
</dict>
</plist>
EOF

# Устанавливаем права доступа
echo "🔐 Установка прав доступа..."
chmod 755 /Library/PreferenceBundles/GuDestroyerPrefs.bundle
chmod 644 /Library/PreferenceBundles/GuDestroyerPrefs.bundle/Info.plist
chmod 644 /Library/PreferenceLoader/Preferences/entry.plist

echo "✅ Настройки установлены!"
echo "🔄 Выполните респринг для активации"
