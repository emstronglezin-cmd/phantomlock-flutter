import 'package:firebase_analytics/firebase_analytics.dart';
import '../core/constants.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Log events
  Future<void> logPinGenerated(String userId) async {
    await _analytics.logEvent(
      name: AppConstants.eventPinGenerated,
      parameters: {'user_id': userId},
    );
  }

  Future<void> logGuestPinEntered({required bool success}) async {
    await _analytics.logEvent(
      name: AppConstants.eventGuestPinEntered,
      parameters: {'success': success},
    );
  }

  Future<void> logCommandSent(String commandType) async {
    await _analytics.logEvent(
      name: AppConstants.eventCommandSent,
      parameters: {'type': commandType},
    );
  }

  Future<void> logPaymentInitiated(String productId, int amount) async {
    await _analytics.logEvent(
      name: AppConstants.eventPaymentInitiated,
      parameters: {'product_id': productId, 'amount': amount},
    );
  }

  Future<void> logPaymentSuccess(String productId, int amount) async {
    await _analytics.logEvent(
      name: AppConstants.eventPaymentSuccess,
      parameters: {'product_id': productId, 'amount': amount},
    );
  }

  Future<void> logPremiumUnlocked(String featureName) async {
    await _analytics.logEvent(
      name: AppConstants.eventPremiumUnlocked,
      parameters: {'feature_name': featureName},
    );
  }

  Future<void> logAppProtected(String deviceModel) async {
    await _analytics.logEvent(
      name: AppConstants.eventAppProtected,
      parameters: {'device_model': deviceModel},
    );
  }

  Future<void> logPhotoTaken() async {
    await _analytics.logEvent(name: AppConstants.eventPhotoTaken);
  }

  Future<void> logLocationShared() async {
    await _analytics.logEvent(name: AppConstants.eventLocationShared);
  }

  // Set user properties
  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }
}
