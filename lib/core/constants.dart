import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// PHANTOMLOCK — CONSTANTES GLOBALES
// ═══════════════════════════════════════════════════════════════════════════

class AppConstants {
  // ─── APP INFO ─────────────────────────────────────────────────────────────
  static const String appName = 'PhantomLock';
  static const String appVersion = '3.0.0';
  static const String appTagline = 'Retrouvez votre téléphone volé en 10 secondes';

  // ─── FIREBASE ─────────────────────────────────────────────────────────────
  // ⚠️ À configurer après création projet Firebase
  static const String firebaseProjectId = 'phantomlock-prod';
  
  // ─── FEDAPAY ──────────────────────────────────────────────────────────────
  // 🔑 Obtenir sur : https://fedapay.com/dashboard
  static const String fedapayPublicKey = 'YOUR_FEDAPAY_PUBLIC_KEY';
  static const String fedapaySecretKey = 'YOUR_FEDAPAY_SECRET_KEY';
  static const String fedapayEnvironment = 'sandbox'; // 'sandbox' ou 'live'
  
  // ─── GOOGLE MAPS ──────────────────────────────────────────────────────────
  // 🔑 Obtenir sur : https://console.cloud.google.com/apis/credentials
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  
  // ─── ADMOB ────────────────────────────────────────────────────────────────
  // 🔑 Obtenir sur : https://admob.google.com
  static const String admobAppId = 'ca-app-pub-3940256099942544~3347511713'; // Test ID
  static const String admobBannerId = 'ca-app-pub-3940256099942544/6300978111'; // Test ID
  static const String admobInterstitialId = 'ca-app-pub-3940256099942544/1033173712'; // Test ID
  
  // ─── PRODUITS PREMIUM ─────────────────────────────────────────────────────
  static const Map<String, int> productPrices = {
    'phantom_photo': 1200,      // 3 photos voleur
    'phantom_itinerary': 600,   // Itinéraire GPS complet
    'phantom_wipe': 1200,       // Effacement total
    'phantom_pack': 1800,       // Pack complet (économie 600 FCFA)
  };
  
  static const Map<String, String> productNames = {
    'phantom_photo': 'Phantom Photo',
    'phantom_itinerary': 'Phantom Itinéraire',
    'phantom_wipe': 'Phantom Wipe',
    'phantom_pack': 'Pack Complet Premium',
  };
  
  static const Map<String, String> productDescriptions = {
    'phantom_photo': '3 photos secrètes du voleur via caméra frontale',
    'phantom_itinerary': 'Itinéraire GPS complet jusqu\'au téléphone',
    'phantom_wipe': 'Effacement total des données à distance',
    'phantom_pack': 'Toutes les fonctionnalités premium (économie 600 FCFA)',
  };
  
  // ─── TIMING ───────────────────────────────────────────────────────────────
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration otpTimeout = Duration(seconds: 60);
  static const Duration locationUpdateInterval = Duration(seconds: 30);
  static const Duration commandTimeout = Duration(seconds: 10);
  
  // ─── LIMITES ──────────────────────────────────────────────────────────────
  static const int maxPhotos = 3;
  static const int pinLength = 10; // Format: PH-XXXX-XX
  static const int otpLength = 6;
  
  // ─── MESSAGES ─────────────────────────────────────────────────────────────
  static const String defaultLockMessage = 
      'Ce téléphone a été volé. Si vous l\'avez trouvé, merci de le retourner.';
  
  // ─── FIREBASE PATHS ───────────────────────────────────────────────────────
  static const String usersPath = 'users';
  static const String pinIndexPath = 'pin_index';
  static const String commandsPath = 'commands';
  static const String locationsPath = 'locations';
  static const String photosPath = 'photos';
  
  // ─── ANALYTICS EVENTS ─────────────────────────────────────────────────────
  static const String eventPinGenerated = 'pin_generated';
  static const String eventGuestPinEntered = 'guest_pin_entered';
  static const String eventCommandSent = 'command_sent';
  static const String eventPaymentInitiated = 'payment_initiated';
  static const String eventPaymentSuccess = 'payment_success';
  static const String eventPremiumUnlocked = 'premium_unlocked';
  static const String eventAppProtected = 'app_protected';
  static const String eventPhotoTaken = 'photo_taken';
  static const String eventLocationShared = 'location_shared';
}

// ═══════════════════════════════════════════════════════════════════════════
// COULEURS PHANTOMLOCK
// ═══════════════════════════════════════════════════════════════════════════

class AppColors {
  // Primaire (Violet / Indigo sombre)
  static const Color primary = Color(0xFF4C1D95);          // Indigo 900
  static const Color primaryLight = Color(0xFF6D28D9);     // Violet 700
  static const Color primaryDark = Color(0xFF2E1065);      // Violet 950
  
  // Accent (Cyan / Bleu électrique)
  static const Color accent = Color(0xFF06B6D4);           // Cyan 500
  static const Color accentLight = Color(0xFF22D3EE);      // Cyan 400
  
  // Status
  static const Color success = Color(0xFF10B981);          // Emerald 500
  static const Color warning = Color(0xFFF59E0B);          // Amber 500
  static const Color error = Color(0xFFEF4444);            // Red 500
  static const Color info = Color(0xFF3B82F6);             // Blue 500
  
  // Neutres
  static const Color background = Color(0xFF0F0E27);       // Très sombre
  static const Color surface = Color(0xFF1E1B4B);          // Indigo 950
  static const Color surfaceLight = Color(0xFF312E81);     // Indigo 900
  
  // Texte
  static const Color textPrimary = Color(0xFFF9FAFB);      // Gray 50
  static const Color textSecondary = Color(0xFFD1D5DB);    // Gray 300
  static const Color textTertiary = Color(0xFF9CA3AF);     // Gray 400
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4C1D95), Color(0xFF6D28D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF0EA5E9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
