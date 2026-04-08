enum CommandType {
  lock,
  locate,
  photo,
  wipe,
  message,
}

enum CommandStatus {
  pending,
  sent,
  received,
  executing,
  completed,
  failed,
}

class CommandModel {
  final String commandId;
  final String userId;
  final CommandType type;
  final CommandStatus status;
  final DateTime timestamp;
  final Map<String, dynamic>? data;
  final String? error;

  CommandModel({
    required this.commandId,
    required this.userId,
    required this.type,
    required this.status,
    required this.timestamp,
    this.data,
    this.error,
  });

  factory CommandModel.fromMap(Map<String, dynamic> map, String commandId) {
    return CommandModel(
      commandId: commandId,
      userId: map['userId'] ?? '',
      type: CommandType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => CommandType.locate,
      ),
      status: CommandStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => CommandStatus.pending,
      ),
      timestamp: DateTime.tryParse(map['timestamp'] ?? '') ?? DateTime.now(),
      data: map['data'],
      error: map['error'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type.name,
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
      'data': data,
      'error': error,
    };
  }

  CommandModel copyWith({
    CommandStatus? status,
    Map<String, dynamic>? data,
    String? error,
  }) {
    return CommandModel(
      commandId: commandId,
      userId: userId,
      type: type,
      status: status ?? this.status,
      timestamp: timestamp,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  String get typeLabel {
    switch (type) {
      case CommandType.lock:
        return 'Bloquer';
      case CommandType.locate:
        return 'Localiser';
      case CommandType.photo:
        return 'Photo';
      case CommandType.wipe:
        return 'Effacer';
      case CommandType.message:
        return 'Message';
    }
  }

  String get statusLabel {
    switch (status) {
      case CommandStatus.pending:
        return 'En attente';
      case CommandStatus.sent:
        return 'Envoyé';
      case CommandStatus.received:
        return 'Reçu';
      case CommandStatus.executing:
        return 'Exécution';
      case CommandStatus.completed:
        return 'Terminé';
      case CommandStatus.failed:
        return 'Échoué';
    }
  }
}
