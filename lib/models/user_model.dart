class UserModel {
  final String userId;
  final String pin; // Hash SHA-256
  final String phone;
  final String? fcmToken;
  final bool isProtected;
  final String customMessage;
  final DateTime createdAt;
  final Map<String, bool> purchases;

  UserModel({
    required this.userId,
    required this.pin,
    required this.phone,
    this.fcmToken,
    required this.isProtected,
    required this.customMessage,
    required this.createdAt,
    required this.purchases,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String userId) {
    return UserModel(
      userId: userId,
      pin: map['pin'] ?? '',
      phone: map['phone'] ?? '',
      fcmToken: map['fcmToken'],
      isProtected: map['isProtected'] ?? false,
      customMessage: map['customMessage'] ?? 'Ce téléphone a été volé',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      purchases: Map<String, bool>.from(map['purchases'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pin': pin,
      'phone': phone,
      'fcmToken': fcmToken,
      'isProtected': isProtected,
      'customMessage': customMessage,
      'createdAt': createdAt.toIso8601String(),
      'purchases': purchases,
    };
  }

  bool hasPurchased(String productId) {
    return purchases[productId] == true;
  }

  UserModel copyWith({
    String? pin,
    String? phone,
    String? fcmToken,
    bool? isProtected,
    String? customMessage,
    Map<String, bool>? purchases,
  }) {
    return UserModel(
      userId: userId,
      pin: pin ?? this.pin,
      phone: phone ?? this.phone,
      fcmToken: fcmToken ?? this.fcmToken,
      isProtected: isProtected ?? this.isProtected,
      customMessage: customMessage ?? this.customMessage,
      createdAt: createdAt,
      purchases: purchases ?? this.purchases,
    );
  }
}
