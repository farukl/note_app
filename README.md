# Flutter Not Uygulaması

## Genel Bakış
Bu Flutter uygulaması, kullanıcıların not almasını, düzenlemesini ve yönetmesini sağlayan kapsamlı bir mobil uygulamadır. Firebase Authentication ve Firestore veritabanı kullanarak güvenli kullanıcı yönetimi ve veri depolama sağlar.

## Özellikler
- Kullanıcı kayıt ve giriş sistemi
- Not ekleme, düzenleme ve silme
- Favori notlar sistemi
- Kullanıcı profil yönetimi
- Tema değiştirme (açık/koyu tema)
- İletişim formu
- Responsive tasarım

## Sayfalar ve İşlevleri

### 1. Login Screen (`login_screen.dart`)
**İşlev:** Kullanıcı giriş sayfası
- E-posta ve şifre ile giriş
- Firebase Authentication entegrasyonu
- Kayıt sayfasına yönlendirme linki
- Yükleme durumu göstergesi
- Hata mesajları

**Temel Özellikler:**
- Form validasyonu
- Güvenli şifre girişi
- Otomatik ana sayfaya yönlendirme

### 2. Register Screen (`register_screen.dart`)
**İşlev:** Yeni kullanıcı kayıt sayfası
- E-posta ve şifre ile kayıt
- Firebase Authentication entegrasyonu
- Başarılı kayıt sonrası otomatik giriş
- Yükleme durumu göstergesi

**Temel Özellikler:**
- Form validasyonu
- Hata yönetimi
- Otomatik ana sayfaya yönlendirme

### 3. Home Screen (`home_screen.dart`)
**İşlev:** Ana dashboard sayfası
- Kullanıcı karşılama mesajı
- Hızlı erişim kartları
- Navigasyon menüsü
- Çıkış yapma butonu

**Erişilebilir Sayfalar:**
- Yeni Not Ekle
- Notlarım
- Favoriler
- Profil
- Bize Ulaşın

### 4. Add Note Screen (`add_note_screen.dart`)
**İşlev:** Yeni not ekleme sayfası
- Çok satırlı metin editörü
- Firestore veritabanına kaydetme
- Boş not kontrolü
- Başarı/hata mesajları

**Veri Yapısı:**
```json
{
  "content": "Not içeriği",
  "isStarred": false,
  "timestamp": "ISO 8601 tarih"
}
```

### 5. Notes Screen (`notes_screen.dart`)
**İşlev:** Tüm notları listeleme ve yönetme
- Not listesi görüntüleme
- Favori ekleme/çıkarma
- Not silme (onay dialogu ile)
- Tarih formatlaması
- Yenileme özelliği (pull-to-refresh)

**İşlevler:**
- Not içeriği önizleme (3 satır max)
- Favori durumu göstergesi
- Silme onay dialogu
- Boş liste durumu yönetimi

### 6. Favorites Screen (`favorites_screen.dart`)
**İşlev:** Favori notları görüntüleme
- Sadece favori işaretli notları gösterir
- Favorilerden çıkarma özelliği
- Yenileme özelliği
- Boş favori listesi durumu

**Özellikler:**
- Filtrelenmiş not listesi
- Otomatik liste güncellemesi
- Kullanıcı dostu boş durum mesajı

### 7. Profile Screen (`profile_screen.dart`)
**İşlev:** Kullanıcı profil yönetimi
- Profil bilgilerini görüntüleme
- Profil düzenleme modu
- Kişisel bilgileri kaydetme
- Tarih seçici

**Profil Alanları:**
- Ad Soyad
- E-posta (salt okunur)
- Doğum Tarihi
- Doğum Yeri
- Şehir

**Özellikler:**
- Görüntüleme/düzenleme modu geçişi
- Form validasyonu
- Tarih seçici widget
- Firestore profil verisi yönetimi

### 8. Contact Screen (`contact_us.dart`)
**İşlev:** İletişim formu
- E-posta gönderme formu
- Form validasyonu
- İletişim bilgileri gösterimi
- Responsive tasarım

**Form Alanları:**
- E-posta adresi (validasyon ile)
- Konu
- Mesaj içeriği

**İletişim Bilgileri:**
- E-posta: destek@notcepte.com
- Telefon: +90 (212) 123 45 67
- Çalışma Saatleri: Pazartesi-Cuma 09:00-18:00

### 9. Settings Screen (`settings_screen.dart`)
**İşlev:** Uygulama ayarları
- Tema değiştirme (açık/koyu)
- Theme Provider entegrasyonu
- Switch kontrolü

## Teknik Yapı

### Providers (Durum Yönetimi)

#### Auth Provider (`auth_provider.dart`)
- Firebase Authentication yönetimi
- Kullanıcı durumu takibi
- Giriş/çıkış işlemleri
- SharedPreferences entegrasyonu

#### Theme Provider (`theme_provider.dart`)
- Uygulama tema yönetimi
- Açık/koyu tema geçişi
- ChangeNotifier pattern

### Servisler

#### Firestore Service (`firestore_services.dart`)
- Not CRUD işlemleri
- Kullanıcı profil yönetimi
- Favori notlar filtreleme
- Veri doğrulama

#### Supabase Service (`supabase_service.dart`)
- Alternatif veri depolama seçeneği
- Profil verisi yönetimi

### Widgets

#### Base Page (`base_page.dart`)
- Ortak sayfa yapısı
- AppBar ve Drawer entegrasyonu
- Tutarlı tasarım dili

## Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK (3.0+)
- Dart SDK (2.17+)
- Firebase projesi
- Android Studio / VS Code

### Bağımlılıklar
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  provider: ^latest
  shared_preferences: ^latest
  supabase: ^latest
```

### Firebase Kurulumu
1. Firebase Console'da yeni proje oluşturun
2. Android/iOS uygulaması ekleyin
3. `google-services.json` ve `GoogleService-Info.plist` dosyalarını ekleyin
4. Authentication ve Firestore'u etkinleştirin

### Çalıştırma
```bash
flutter pub get
flutter run
```

## Veri Yapısı

### Kullanıcı Profili
```json
{
  "name": "string",
  "email": "string",
  "birthDate": "string",
  "birthPlace": "string",
  "city": "string",
  "updatedAt": "ISO 8601 string"
}
```

### Not Yapısı
```json
{
  "content": "string",
  "isStarred": "boolean",
  "timestamp": "ISO 8601 string"
}
```

## Güvenlik
- Firebase Security Rules
- Kullanıcı bazlı veri erişimi
- Giriş durumu kontrolü
- Form validasyonu

## Kullanıcı Deneyimi
- Responsive tasarım
- Loading states
- Hata mesajları
- Başarı bildirimleri
- Pull-to-refresh
- Boş durum yönetimi

## Geliştirme Notları
- Clean Architecture prensiplerine uygun
- Provider pattern ile state management
- Reusable widget yapısı
- Comprehensive error handling
- User-friendly interface

## Gelecek Geliştirmeler
- Not kategorileri
- Arama özelliği
- Not paylaşma
- Offline çalışma
- Push notifications
- Rich text editing
- Dosya ekleme özelliği
