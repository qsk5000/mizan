# تطبيق ميزانيق - mizaniq.online
## تطبيق WebView لـ Android و iOS

---

## 📋 المتطلبات

- Flutter SDK (3.0.0 أو أحدث)
- Android Studio أو VS Code
- Xcode (لـ iOS - يحتاج Mac)
- Git

---

## 🚀 طريقة التشغيل

### 1. تثبيت الحزم
```bash
flutter pub get
```

### 2. تشغيل على Android
```bash
flutter run
```

### 3. بناء APK للنشر
```bash
flutter build apk --release
```
الملف سيكون في: `build/app/outputs/flutter-apk/app-release.apk`

### 4. بناء App Bundle (للنشر على Google Play)
```bash
flutter build appbundle --release
```

### 5. بناء iOS (يحتاج Mac + Xcode)
```bash
flutter build ios --release
```

---

## ✨ مميزات التطبيق

- ✅ يفتح موقع mizaniq.online مباشرة
- ✅ شاشة Splash Screen جميلة عند الفتح
- ✅ شريط تحميل أثناء تصفح الصفحات
- ✅ يدعم زر الرجوع (Back Button)
- ✅ رسالة تأكيد عند الخروج من التطبيق
- ✅ شاشة "لا يوجد إنترنت" مع زر إعادة المحاولة
- ✅ شاشة خطأ مع زر إعادة التحميل
- ✅ يدعم JavaScript بالكامل
- ✅ يدعم Android و iOS

---

## 📁 هيكل المشروع

```
mizaniq_app/
├── lib/
│   └── main.dart          ← الكود الرئيسي
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml
├── ios/
│   └── Runner/
│       └── Info.plist
└── pubspec.yaml           ← إعدادات المشروع والحزم
```

---

## 🔧 تعديل الرابط

إذا أردت تغيير رابط الموقع، افتح `lib/main.dart` وابحث عن:
```dart
final String _url = 'https://www.mizaniq.online';
```
وغيّره إلى الرابط الذي تريد.

---

## 📦 الحزم المستخدمة

| الحزمة | الاستخدام |
|--------|-----------|
| `webview_flutter` | عرض الموقع داخل التطبيق |
| `connectivity_plus` | كشف حالة الإنترنت |

---

## 🆘 للمساعدة

- تأكد من تثبيت Flutter: `flutter doctor`
- تأكد من الأجهزة المتصلة: `flutter devices`
