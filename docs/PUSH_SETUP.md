# Проверка пуш-уведомлений

## 1. Получить FCM-токен

В логах при запуске приложения ищи строку:
```
FCM Token: ...
```

- Если видишь **FCM Token: null** или ошибку `Firebase Installations Service is unavailable`:
  - **Эмулятор Android:** используй образ с **Google Play** (Google APIs), обнови Google Play Services.
  - **Реальное устройство:** проверь интернет (Wi‑Fi или мобильные данные).
  - Перезапусти приложение (полный стоп и запуск).

- Скопируй токен и используй его в Firebase Console или на бэкенде для отправки тестового пуша.

## 2. Тест из Firebase Console

1. [Firebase Console](https://console.firebase.google.com) → проект **manassuu-27ca8** → Cloud Messaging.
2. «Create your first campaign» или «New campaign» → **Firebase Notification messages**.
3. Заполни заголовок и текст → Next.
4. В «Target» выбери «Send to single device» и вставь свой **FCM Token**.
5. Отправь.

## 3. Поведение по состоянию приложения

| Состояние приложения | Где показывается уведомление |
|----------------------|------------------------------|
| **Foreground** (приложение открыто) | Локальное уведомление через `flutter_local_notifications` |
| **Background** (свёрнуто) | Системный трей (FCM) |
| **Terminated** (закрыто) | Системный трей (FCM) |

Проверяй в **background** или **terminated** — пуши должны приходить в трей.

## 4. Android

- **Android 13+:** при первом запуске приложение запрашивает разрешение «Уведомления» (через `permission_handler`). Без него пуши в трей не показываются — при отказе зайди в Настройки → Приложения → manas_suu_app → Уведомления → Включить.
- В манифесте не должно быть своего `FirebaseMessagingService` — используется реализация из плагина Flutter.
- Канал `high_importance_channel` создаётся при первом запуске в `LocalNotificationsService`.
- **Проверка:** в логах при запуске должна быть строка `FCM Token: ...`. При тесте из консоли: сверни приложение (не закрывай) → отправь тест по токену из логов → подожди 5–10 сек.

## 5. iOS

- Пуши **не работают в симуляторе** — только на реальном устройстве.
- В Firebase Console: Project Settings → Cloud Messaging → Apple app configuration → загружен **APNs Authentication Key** (или сертификат).
- В Xcode: Signing & Capabilities → включена **Push Notifications**.
- При первом запуске на устройстве должно появиться запрос разрешения на уведомления.

## 6. Отправка с бэкенда — FCM HTTP v1 API (актуальный способ)

**Cloud Messaging API (Legacy)** и Server Key устарели. Используй **FCM HTTP v1**.

### Шаг 1: Ключ сервисного аккаунта

1. [Firebase Console](https://console.firebase.google.com) → проект → **Project settings** (шестерёнка) → вкладка **Service accounts**.
2. Нажми **Generate new private key** → скачается JSON-файл (храни в секрете, не коммить в репозиторий).
3. В этом JSON нужны поля `client_email` и `private_key` — их использует бэкенд для получения OAuth2 access token.

### Шаг 2: Access token (OAuth 2.0)

Сервер по JSON ключа запрашивает JWT и обменивает его на access token с областью `https://www.googleapis.com/auth/firebase.messaging`.  
Документация: [Obtain an access token](https://firebase.google.com/docs/cloud-messaging/auth-server#authorize_requests_to_fcm_legacy_http_api).

Кратко: из `private_key` подписываешь JWT с `client_email` как `iss`, затем POST на `https://oauth2.googleapis.com/token` с `grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer` и `assertion=<JWT>` — в ответе будет `access_token`.

### Шаг 3: Отправка запроса (v1)

- **URL:** `https://fcm.googleapis.com/v1/projects/PROJECT_ID/messages:send`  
  `PROJECT_ID` — из Firebase (у тебя **manassuu-27ca8**).
- **Заголовки:**  
  `Authorization: Bearer ACCESS_TOKEN`  
  `Content-Type: application/json`
- **Тело (JSON):**

```json
{
  "message": {
    "token": "FCM_ТОКЕН_УСТРОЙСТВА",
    "notification": {
      "title": "Заголовок",
      "body": "Текст уведомления"
    }
  }
}
```

Пример curl (токен нужно подставить после получения через OAuth2):

```bash
curl -X POST "https://fcm.googleapis.com/v1/projects/manassuu-27ca8/messages:send" \
  -H "Authorization: Bearer ВАШ_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "message": {
      "token": "FCM_ТОКЕН_УСТРОЙСТВА",
      "notification": {
        "title": "Тест",
        "body": "Проверка пуша"
      }
    }
  }'
```

Документация v1: [Send messages with the FCM v1 HTTP API](https://firebase.google.com/docs/cloud-messaging/send-message).

---

## 7. Токен правильный, но пуши не приходят — что проверить

### Формат запроса (FCM v1)

**FCM HTTP v1** (рекомендуется, Legacy устарел):

- URL: `https://fcm.googleapis.com/v1/projects/PROJECT_ID/messages:send`
- Заголовок: `Authorization: Bearer ACCESS_TOKEN` (токен получаешь по ключу сервисного аккаунта, см. раздел 6 выше).
- Тело — объект `message` с полем `token` (FCM-токен устройства) и `notification` и/или `data`:

```json
{
  "message": {
    "token": "FCM_ТОКЕН_УСТРОЙСТВА",
    "notification": {
      "title": "Заголовок",
      "body": "Текст уведомления"
    }
  }
}
```

Data-only (приложение само покажет уведомление из `data`):

```json
{
  "message": {
    "token": "FCM_ТОКЕН",
    "data": {
      "title": "Заголовок",
      "body": "Текст"
    }
  }
}
```

### Частые причины

| Причина | Что сделать |
|--------|-------------|
| **Только `data`, без `notification`** | В background на Android система не показывает уведомление сама. В приложении теперь обрабатываются и data-only (показ через локальные уведомления). Убедись, что в `data` есть `title` и/или `body`. |
| **Неверный access token / не тот проект** | Token получай по ключу сервисного аккаунта того же проекта. Project ID должен совпадать с `google-services.json`. |
| **Формат v1** | Тело — объект `{"message": {"token": "...", "notification": {...}}}`, не `to` и не `notification` в корне. См. [FCM v1](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages). |
| **iOS без APNs** | В консоли Firebase для iOS-приложения должен быть загружен APNs key (или сертификат). Без этого пуши на iOS не доходят. |
| **Эмулятор / симулятор** | Android: эмулятор с Google Play. iOS: пуши только на реальном устройстве. |
| **Сеть** | Доступ к `fcm.googleapis.com` и `firebaseinstallations.googleapis.com`. Отключи VPN/прокси при проверке. |
| **Токен устарел** | После переустановки приложения или долгого неиспользования токен меняется. Всегда бери актуальный из логов при запуске. |

### Быстрый тест из консоли Firebase

Cloud Messaging → New campaign → Notification → Send test message → ввести FCM token. Если и так не приходит — проблема на стороне устройства/сети или разрешений, а не бэкенда.

---

## 8. «Не работает» — пройди по списку

Проверь по порядку. После каждого пункта пробуй отправить тест из Firebase Console (Test on device).

1. **Реальное устройство**  
   Эмулятор без Google Play пуши не получит. Нужен телефон/планшет с интернетом.

2. **Токен из текущего запуска**  
   В Android Studio / VS Code в логах (Run / Debug console) при запуске приложения должна быть строка `FCM Token: <длинная строка>`. Скопируй её целиком и вставь в Firebase → Test on device. Старый токен (например из «Recently used») мог уже быть недействителен.

3. **Разрешение «Уведомления» (Android 13+)**  
   Настройки → Приложения → manas_suu_app → Уведомления → переключатель **Включить**. Если уведомления выключены, пуши в трей не показываются.

4. **Проверка в foreground**  
   Оставь приложение **открытым** на экране. Отправь тест по токену из консоли. Должно появиться **локальное** уведомление (наше приложение его рисует). Если в foreground приходит, а в background нет — смотри п.5.

5. **Проверка в background**  
   Сверни приложение (кнопка Home), не закрывай из списка недавних. Отправь тест. Подожди 5–10 секунд. Должно появиться уведомление в шторке. Если не появляется — настройки батареи (п.6).

6. **Батарея и фон (Xiaomi, Oppo, Huawei, Realme и др.)**  
   Настройки → Батарея → Ограничение фона / Экономия батареи → для **manas_suu_app** выбери «Без ограничений» или «Не оптимизировать». В настройках приложения включи «Автозапуск» / «Запуск в фоне», если есть такие пункты.

7. **Один проект Firebase**  
   В консоли должен быть выбран проект **manassuu-27ca8**. В приложении в `google-services.json` тот же `project_id` и `package_name`: **com.example.manas_suu_app**. Менять проект или package без пересборки приложения нельзя.

8. **Полная пересборка**  
   В терминале: `flutter clean`, затем `flutter pub get`, затем снова запуск на устройстве. После этого заново возьми токен из логов и снова отправь тест.
