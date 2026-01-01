import 'package:uuid/uuid.dart';

class QueueItem {
  final String id;
  final String name;
  final DateTime joinedAt;
  
  // Optional: Add visual properties like avatar color or icon index
  final int avatarIndex; 

  QueueItem({
    required this.id,
    required this.name,
    required this.joinedAt,
    this.avatarIndex = 0,
  });

  factory QueueItem.create({required String name, int avatarIndex = 0}) {
    return QueueItem(
      id: const Uuid().v4(),
      name: name,
      joinedAt: DateTime.now(),
      avatarIndex: avatarIndex,
    );
  }

  factory QueueItem.fromJson(Map<String, dynamic> json) {
    return QueueItem(
      id: json['id'] as String,
      name: json['name'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      avatarIndex: json['avatar_index'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'joined_at': joinedAt.toIso8601String(),
      'avatar_index': avatarIndex,
    };
  }
}
