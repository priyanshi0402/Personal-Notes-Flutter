import '../helper/helper_class.dart';

class Users {
  final String id;
  String name;
  String email;
  String profileImage;
  String phoneNumber;

  Users(this.id, this.name, this.email, this.profileImage,
      {this.phoneNumber = ""});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> userModelMap = {};
    userModelMap[FirebaseKeys.userId] = id;
    userModelMap[FirebaseKeys.username] = name;
    userModelMap[FirebaseKeys.email] = email;
    userModelMap[FirebaseKeys.profileImage] = profileImage;
    userModelMap[FirebaseKeys.phoneNumber] = phoneNumber;
    return userModelMap;
  }

  factory Users.fromMap(Map<dynamic, dynamic> json) => Users(
      json[FirebaseKeys.userId],
      json[FirebaseKeys.username],
      json[FirebaseKeys.email],
      json[FirebaseKeys.profileImage],
      phoneNumber: json[FirebaseKeys.phoneNumber] ?? "");
}
