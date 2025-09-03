# 📱 Установка GuDestroyer

## 🚀 Быстрая установка

### 1. Установка основного твика

```bash
# Копируем .deb файл на устройство
scp packages/com.greatlove.gudestroyer_1.0.0-3+debug_iphoneos-arm.deb root@<device-ip>:/tmp/

# Подключаемся к устройству
ssh root@<device-ip>

# Устанавливаем твик
dpkg -i /tmp/com.greatlove.gudestroyer_1.0.0-3+debug_iphoneos-arm.deb
```

### 2. Установка настроек

```bash
# Копируем скрипт установки настроек
scp install_settings.sh root@<device-ip>:/tmp/

# Запускаем скрипт
ssh root@<device-ip> "chmod +x /tmp/install_settings.sh && /tmp/install_settings.sh"
```

### 3. Активация

```bash
# Выполняем респринг
ssh root@<device-ip> "killall -9 SpringBoard"
```

## ⚙️ Настройка

1. **Откройте Настройки** на устройстве
2. **Найдите GuDestroyer** в списке твиков
3. **Нажмите на него** - откроется интерфейс настроек
4. **Включите твик** переключателем
5. **Настройте сообщения** (опционально)
6. **Добавьте приложения** в список блокировки

## 🧪 Тестирование

### Быстрый тест

1. **Включите GuDestroyer** в настройках
2. **Добавьте Safari** в список блокировки:
   - Bundle ID: `com.apple.mobilesafari`
3. **Попытайтесь открыть Safari**
4. **Результат:** Появится уведомление о блокировке

### Примеры Bundle ID

```bash
# Популярные приложения
com.facebook.Facebook          # Facebook
com.twitter.twitter            # Twitter
com.instagram.instagram        # Instagram
com.netflix.Netflix            # Netflix
com.youtube.ios                # YouTube
com.spotify.client             # Spotify
com.whatsapp.WhatsApp          # WhatsApp
com.telegram.Telegram          # Telegram
```

## 🔧 Ручная настройка

Если автоматическая установка не работает, можно настроить вручную:

### 1. Создание настроек

```bash
# Подключаемся к устройству
ssh root@<device-ip>

# Создаем настройки по умолчанию
defaults write com.greatlove.gudestroyer enabled -bool false
defaults write com.greatlove.gudestroyer blockedApps -array
defaults write com.greatlove.gudestroyer alertTitle "Приложение заблокировано"
defaults write com.greatlove.gudestroyer alertMessage "Это приложение заблокировано GuDestroyer"
```

### 2. Добавление приложения в список блокировки

```bash
# Добавляем Safari в список блокировки
defaults write com.greatlove.gudestroyer blockedApps -array-add "com.apple.mobilesafari"

# Включаем твик
defaults write com.greatlove.gudestroyer enabled -bool true
```

## 🐛 Устранение неполадок

### Твик не появляется в настройках

```bash
# Проверяем установку
ls -la /Library/PreferenceLoader/Preferences/entry.plist

# Если файл отсутствует, копируем вручную
cp entry.plist /Library/PreferenceLoader/Preferences/
```

### Приложения не блокируются

```bash
# Проверяем настройки
defaults read com.greatlove.gudestroyer

# Проверяем включен ли твик
defaults read com.greatlove.gudestroyer enabled
```

### SpringBoard крашится

```bash
# Загружаемся в безопасном режиме
# Удаляем твик
dpkg -r com.greatlove.gudestroyer

# Очищаем настройки
defaults delete com.greatlove.gudestroyer
```

## 📝 Логирование

### Просмотр логов

```bash
# Подключаемся к устройству
ssh root@<device-ip>

# Просматриваем логи SpringBoard
tail -f /var/log/syslog | grep -i gudestroyer
```

### Отладка

```bash
# Проверяем статус твика
ps aux | grep GuDestroyer

# Проверяем загруженные твики
ls -la /Library/MobileSubstrate/DynamicLibraries/
```

## 🎯 Готово!

После установки и настройки GuDestroyer будет блокировать выбранные приложения с настраиваемыми уведомлениями.

**Следующие шаги:**
1. Настройте список заблокированных приложений
2. Кастомизируйте сообщения
3. Протестируйте на разных приложениях
4. Наслаждайтесь контролем над своими приложениями!

---

*Создано Great Love с ❤️ для сообщества jailbreak*
