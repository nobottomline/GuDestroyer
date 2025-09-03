# 🚀 GuDestroyer - Быстрый старт

## ⚡ Установка за 5 минут

### 1. Подготовка (2 минуты)

```bash
# Установка Theos (если не установлен)
bash -c "$(curl -fsSL https://raw.githubusercontent.com/theos/theos/master/bin/install-theos)"

# Настройка переменных окружения
export THEOS=/opt/theos
export PATH=$THEOS/bin:$PATH
```

### 2. Сборка проекта (1 минута)

```bash
# Клонирование или скачивание проекта
cd GuDestroyer

# Автоматическая сборка и установка
./build.sh
```

### 3. Активация (2 минуты)

1. **Респринг устройства** (перезапуск SpringBoard)
2. **Открыть Настройки** → найти **GuDestroyer**
3. **Включить твик** переключателем
4. **Настроить сообщения** (опционально)
5. **Добавить приложения** в список блокировки

## 🎯 Первое использование

### Быстрый тест

1. **Включить GuDestroyer** в настройках
2. **Добавить Safari** в список блокировки:
   - Bundle ID: `com.apple.mobilesafari`
3. **Попытаться открыть Safari**
4. **Результат:** Появится уведомление о блокировке

### Настройка сообщений

```objc
// Примеры настраиваемых сообщений
Заголовок: "🚫 Доступ запрещен"
Сообщение: "Это приложение временно заблокировано"
```

## 📱 Популярные Bundle ID

```bash
# Социальные сети
com.facebook.Facebook          # Facebook
com.twitter.twitter            # Twitter
com.instagram.instagram        # Instagram
com.snapchat.snapchat          # Snapchat

# Игры
com.supercell.clashofclans     # Clash of Clans
com.king.candycrushsaga        # Candy Crush
com.epicgames.fortnite         # Fortnite

# Развлечения
com.netflix.Netflix            # Netflix
com.youtube.ios                # YouTube
com.spotify.client             # Spotify

# Мессенджеры
com.whatsapp.WhatsApp          # WhatsApp
com.telegram.Telegram          # Telegram
com.viber                      # Viber
```

## 🔧 Полезные команды

### Сборка и установка
```bash
make clean && make package    # Очистка и сборка
make install                  # Установка на устройство
./build.sh                    # Автоматическая сборка
```

### Отладка
```bash
# Просмотр логов
ssh root@<device-ip> "tail -f /var/log/syslog | grep GuDestroyer"

# Проверка установки
ssh root@<device-ip> "dpkg -l | grep gudestroyer"
```

### Управление
```bash
# Удаление твика
ssh root@<device-ip> "dpkg -r com.greatlove.gudestroyer"

# Респринг
ssh root@<device-ip> "killall -9 SpringBoard"
```

## ⚠️ Важные замечания

### Безопасность
- **Всегда тестируйте** на неважных приложениях
- **Используйте безопасный режим** при проблемах
- **Делайте резервные копии** перед установкой

### Производительность
- Твик имеет **минимальное влияние** на производительность
- **Не блокируйте системные приложения** (SpringBoard, Settings)
- **Используйте разумное количество** заблокированных приложений

## 🆘 Решение проблем

### Твик не появляется в настройках
```bash
# Решение
1. Убедитесь, что PreferenceLoader установлен
2. Выполните респринг
3. Переустановите твик
```

### Приложения не блокируются
```bash
# Проверка
1. Включен ли твик в настройках
2. Правильный ли Bundle ID
3. Применены ли настройки
```

### SpringBoard крашится
```bash
# Экстренное решение
1. Загрузитесь в безопасном режиме
2. Удалите твик
3. Проверьте логи на ошибки
```

## 📚 Дополнительные ресурсы

- **README.md** - Полная документация
- **TESTING.md** - Руководство по тестированию
- **PROJECT_INFO.md** - Техническая информация
- **example_blocked_apps.plist** - Примеры приложений

## 🎉 Готово!

Теперь у вас есть полностью функциональный твик GuDestroyer! 

**Следующие шаги:**
1. Настройте список заблокированных приложений
2. Кастомизируйте сообщения
3. Протестируйте на разных приложениях
4. Наслаждайтесь контролем над своими приложениями!

---

*Создано Great Love с ❤️ для сообщества jailbreak*
