import '../helper/helper_class.dart';

class Notes {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String attachments;
  final String createdAt;

  Notes(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.attachments,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> userModelMap = {};
    userModelMap[FirebaseKeys.id] = id;
    userModelMap[FirebaseKeys.userId] = userId;
    userModelMap[FirebaseKeys.title] = title;
    userModelMap[FirebaseKeys.description] = description;
    userModelMap[FirebaseKeys.attachments] = attachments;
    userModelMap[FirebaseKeys.createdAt] = createdAt;
    return userModelMap;
  }

  factory Notes.fromMap(Map<dynamic, dynamic> json, String id) => Notes(
      id: id,
      userId: json[FirebaseKeys.userId],
      title: json[FirebaseKeys.title],
      description: json[FirebaseKeys.description],
      attachments: json[FirebaseKeys.attachments],
      createdAt: json[FirebaseKeys.createdAt]);
}
