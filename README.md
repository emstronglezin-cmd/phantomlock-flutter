# 🔒 PhantomLock v3.0 — Application Anti-Vol Android

**Application Android complète avec Firebase + Fedapay + Google Maps + Analytics**

> ⚠️ **IMPORTANT** : Ce projet nécessite 4+ GB RAM pour le build. Le build APK a échoué dans l'environnement sandbox (987 MB).  
> **Solution** : Builder sur ton PC ou via GitHub Actions (instructions ci-dessous).

---

## 🎯 Fonctionnalités

### ✅ Gratuit
- 📱 Inscription par SMS (Firebase Auth)
- 🔐 Code PIN unique (format PH-XXXX-XX)
- 📍 Localisation GPS en temps réel
- 🔒 Verrouillage à distance
- 💬 Message personnalisé sur écran de verrouillage
- 🔔 Notifications push (Firebase Cloud Messaging)

### 💎 Premium (Fedapay : Orange Money, Moov, Cartes)
- 📸 **Phantom Photo** (1200 FCFA) : 3 photos secrètes du voleur
- 🗺️ **Phantom Itinéraire** (600 FCFA) : Navigation GPS complète
- 🗑️ **Phantom Wipe** (1200 FCFA) : Effacement total des données
- 🎁 **Pack Complet** (1800 FCFA) : Toutes les fonctionnalités (économie 600 FCFA)

---

## 🏗️ Architecture

```
lib/
├── core/
│   ├── constants.dart         # Config API, produits, couleurs
│   └── theme.dart              # Thème Material 3 dark
├── models/
│   ├── user_model.dart         # Modèle utilisateur
│   ├── command_model.dart      # Modèle commandes
│   └── payment_model.dart      # Modèle paiements
├── services/
│   ├── analytics_service.dart  # Firebase Analytics
│   ├── auth_service.dart       # Firebase Auth SMS
│   ├── firebase_service.dart   # Realtime DB + Storage
│   ├── fcm_service.dart        # Push notifications
│   ├── location_service.dart   # GPS tracking
│   ├── camera_service.dart     # Photo secrète
│   ├── background_service.dart # Service Android persistant
│   ├── device_admin_service.dart # Verrouillage système
│   ├── fedapay_service.dart    # Paiements Orange/Moov
│   └── admob_service.dart      # Publicités
├── screens/
│   ├── splash_screen.dart      # ✅ CRÉÉ
│   ├── onboarding_screen.dart
│   ├── auth/
│   │   ├── phone_input_screen.dart
│   │   ├── otp_screen.dart
│   │   └── pin_reveal_screen.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── settings_screen.dart
│   ├── guest/
│   │   ├── guest_entry_screen.dart
│   │   ├── control_screen.dart
│   │   ├── map_screen.dart
│   │   └── thief_photos_screen.dart
│   └── payment/
│       ├── payment_webview_screen.dart
│       └── payment_success_screen.dart
├── widgets/
│   ├── phantom_button.dart
│   ├── status_badge.dart
│   └── ad_banner.dart
├── main.dart                  # ✅ CRÉÉ
└── app.dart                   # ✅ CRÉÉ
```

---

## 🔧 Configuration Requise

### 1. Firebase
1. Crée un projet sur **https://console.firebase.google.com**
2. Active :
   - **Authentication** → Phone (SMS)
   - **Realtime Database**
   - **Cloud Storage**
   - **Cloud Messaging**
   - **Analytics**
   - **Crashlytics**
3. Télécharge `google-services.json` → place dans `android/app/`
4. Copie les règles de sécurité (voir section Firebase Rules)

### 2. Fedapay (Paiements)
1. Crée un compte sur **https://fedapay.com**
2. Obtiens `PUBLIC_KEY` et `SECRET_KEY` depuis le dashboard
3. Configure dans `lib/core/constants.dart` :
```dart
static const String fedapayPublicKey = 'TON_FEDAPAY_PUBLIC_KEY';
static const String fedapaySecretKey = 'TON_FEDAPAY_SECRET_KEY';
static const String fedapayEnvironment = 'sandbox'; // ou 'live'
```

### 3. Google Maps
1. Active **Maps SDK for Android** sur **https://console.cloud.google.com**
2. Crée une clé API avec restriction Android
3. Configure dans `lib/core/constants.dart` :
```dart
static const String googleMapsApiKey = 'TON_GOOGLE_MAPS_API_KEY';
```

### 4. AdMob (Optionnel)
1. Crée une app sur **https://admob.google.com**
2. Remplace les IDs de test dans `lib/core/constants.dart`

---

## 📦 Build APK

### Option 1 : Build Local (PC avec 4+ GB RAM)

```bash
# 1. Clone le repo
git clone https://github.com/emstronglezin-cmd/phantomlock-flutter
cd phantomlock-flutter

# 2. Installe les dépendances
flutter pub get

# 3. Configure Firebase
# Place google-services.json dans android/app/

# 4. Build APK
flutter build apk --release

# APK disponible dans : build/app/outputs/flutter-apk/app-release.apk
```

### Option 2 : GitHub Actions (Automatique)

Le repo contient déjà un workflow `.github/workflows/build.yml` qui :
- Build automatiquement à chaque push
- Génère APK + AAB
- Crée une release GitHub

**Activation** (une seule fois) :
1. Va sur **https://github.com/settings/tokens**
2. Edit ton token → coche `workflow` → Update
3. Lance cette commande (remplace TON_TOKEN) :

```bash
TOKEN="TON_NOUVEAU_TOKEN_AVEC_WORKFLOW"

curl -s -X PUT \
  -H "Authorization: token $TOKEN" \
  -H "Content-Type: application/json" \
  "https://api.github.com/repos/emstronglezin-cmd/phantomlock-flutter/contents/.github/workflows/build.yml" \
  -d "{\"message\":\"ci: activate build\",\"content\":\"$(curl -s https://raw.githubusercontent.com/emstronglezin-cmd/phantomlock-flutter/main/BUILD_WORKFLOW.yml | base64 -w 0)\"}"
```

Ensuite :
- Chaque push déclenche le build automatique
- Télécharge l'APK sur : **https://github.com/emstronglezin-cmd/phantomlock-flutter/releases**

---

## 🔥 Firebase Realtime Database Rules

```json
{
  "rules": {
    "users": {
      "$uid": {
        ".read": "auth.uid === $uid",
        ".write": "auth.uid === $uid"
      }
    },
    "pin_index": {
      ".read": true,
      ".write": "auth != null"
    },
    "commands": {
      "$commandId": {
        ".read": "auth != null",
        ".write": "auth != null"
      }
    },
    "locations": {
      "$uid": {
        ".read": "auth.uid === $uid",
        ".write": "auth.uid === $uid"
      }
    }
  }
}
```

---

## 📊 Firebase Storage Rules

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /photos/{userId}/{photoId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

---

## ☁️ Cloud Functions (Fedapay Webhook)

Crée `functions/index.js` :

```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const axios = require('axios');

admin.initializeApp();

// Initier un paiement Fedapay
exports.initFedapayPayment = functions.https.onCall(async (data, context) => {
  const { productId, amount, phone } = data;
  const userId = context.auth.uid;

  const response = await axios.post('https://api.fedapay.com/v1/transactions', {
    amount,
    currency: {code: 'XOF'},
    description: `PhantomLock - ${productId}`,
    callback_url: `https://YOUR_PROJECT_ID.cloudfunctions.net/fedapayWebhook`,
    customer: {phone_number: {number: phone, country: 'bj'}},
  }, {
    headers: {
      'Authorization': `Bearer ${functions.config().fedapay.secret}`,
      'Content-Type': 'application/json',
    }
  });

  // Stocker transaction ID
  await admin.database().ref(`payments/${userId}/${productId}`).set({
    transactionId: response.data.id,
    status: 'pending',
    createdAt: Date.now(),
  });

  return {url: response.data.url, transactionId: response.data.id};
});

// Webhook Fedapay
exports.fedapayWebhook = functions.https.onRequest(async (req, res) => {
  const { id, status } = req.body;

  if (status === 'approved') {
    // Récupérer userId depuis transaction
    const snapshot = await admin.database().ref('payments').orderByChild('transactionId').equalTo(id).once('value');
    
    if (snapshot.exists()) {
      const data = snapshot.val();
      const userId = Object.keys(data)[0];
      const productId = Object.keys(data[userId])[0];

      // Débloquer la fonctionnalité
      await admin.database().ref(`users/${userId}/purchases/${productId}`).set(true);
      
      // Analytics
      await admin.analytics().logEvent('payment_success', {product_id: productId});
    }
  }

  res.status(200).send('OK');
});
```

Déploie :
```bash
firebase deploy --only functions
```

---

## 📱 Permissions Android (AndroidManifest.xml)

Ajoute dans `android/app/src/main/AndroidManifest.xml` :

```xml
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.DISABLE_KEYGUARD"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
<uses-permission android:name="android.permission.BIND_DEVICE_ADMIN"/>
```

---

## 🚀 État Actuel

### ✅ Créé
- Structure complète du projet
- Fichiers core (constants, theme)
- Models (user, command, payment)
- Services (analytics, minimal)
- Écran splash fonctionnel
- Configuration Android de base

### ⏳ À Compléter
- 40+ fichiers services restants
- 15+ écrans
- Widgets personnalisés
- DeviceAdminReceiver (Kotlin)
- Cloud Functions complètes
- Tests

---

## 📞 Support

**Développeur** : PhantomLock Team  
**Repo** : https://github.com/emstronglezin-cmd/phantomlock-flutter  
**Issues** : https://github.com/emstronglezin-cmd/phantomlock-flutter/issues

---

## 📄 Licence

Propriétaire — Tous droits réservés © 2026 PhantomLock
