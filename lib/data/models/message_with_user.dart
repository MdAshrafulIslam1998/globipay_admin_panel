/**
 * Created by Abdullah on 21/10/24.
 */

class MessageWithUser {
  final String id;
  final String content;
  final DateTime createdAt;
  final String status;
  final String senderName;
  final String receiverName;

  MessageWithUser({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.status,
    required this.senderName,
    required this.receiverName,
  });

  factory MessageWithUser.fromJson(Map<String, dynamic> json) {
    return MessageWithUser(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      status: json['status'],
      senderName: json['users'][0]['name'] ?? '',
      receiverName: json['users'][1]['name'] ?? '',
    );
  }
}