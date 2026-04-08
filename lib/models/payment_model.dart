class LocationModel {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final DateTime timestamp;
  final String? address;

  LocationModel({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    required this.timestamp,
    this.address,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
      accuracy: map['accuracy']?.toDouble(),
      timestamp: DateTime.tryParse(map['timestamp'] ?? '') ?? DateTime.now(),
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'timestamp': timestamp.toIso8601String(),
      'address': address,
    };
  }

  @override
  String toString() {
    return 'LocationModel(lat: $latitude, lng: $longitude, time: $timestamp)';
  }
}

class PaymentModel {
  final String transactionId;
  final String userId;
  final String productId;
  final int amount;
  final String currency;
  final String status; // 'pending', 'success', 'failed'
  final String? fedapayTransactionId;
  final DateTime createdAt;
  final DateTime? completedAt;

  PaymentModel({
    required this.transactionId,
    required this.userId,
    required this.productId,
    required this.amount,
    this.currency = 'XOF',
    required this.status,
    this.fedapayTransactionId,
    required this.createdAt,
    this.completedAt,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map, String transactionId) {
    return PaymentModel(
      transactionId: transactionId,
      userId: map['userId'] ?? '',
      productId: map['productId'] ?? '',
      amount: map['amount'] ?? 0,
      currency: map['currency'] ?? 'XOF',
      status: map['status'] ?? 'pending',
      fedapayTransactionId: map['fedapayTransactionId'],
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      completedAt: map['completedAt'] != null ? DateTime.tryParse(map['completedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'fedapayTransactionId': fedapayTransactionId,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  PaymentModel copyWith({
    String? status,
    String? fedapayTransactionId,
    DateTime? completedAt,
  }) {
    return PaymentModel(
      transactionId: transactionId,
      userId: userId,
      productId: productId,
      amount: amount,
      currency: currency,
      status: status ?? this.status,
      fedapayTransactionId: fedapayTransactionId ?? this.fedapayTransactionId,
      createdAt: createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  bool get isCompleted => status == 'success';
  bool get isPending => status == 'pending';
  bool get isFailed => status == 'failed';
}
