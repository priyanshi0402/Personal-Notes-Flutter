import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:personal_notes/src/helper/helper_class.dart';
import 'package:personal_notes/src/model/messages.dart';
import 'package:rxdart/rxdart.dart';

class ChatHelper {
  static Stream<List<MessagesChat>> getChatMessages(
      String groupChatID, int limit) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    Stream<List<MessagesChat>> messages = const Stream.empty();

    messages = firebaseFirestore
        .collection(FirebaseKeys.messagesCollection)
        .doc(groupChatID)
        .collection(groupChatID)
        .orderBy(FirebaseKeys.timestamp, descending: true)
        .limit(limit)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return MessagesChat.fromMap(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return value.toMap();
          },
        )
        .snapshots(includeMetadataChanges: true)
        .map((event) => event.docs.map((doc) => doc.data()).toList())
        .onErrorResume((error, stackTrace) {
          return messages;
        });

    return messages;
  }

  static Future<void> sendMessage(String content, int type, String chatID,
      String currentUserId, String peerId, String filename,
      {String thumbnail = ""}) async {
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    MessagesChat chatModel = MessagesChat(
        idFrom: currentUserId,
        idTo: peerId,
        timeStamp: timeStamp,
        content: content,
        videothumbnail: thumbnail,
        filename: filename,
        type: type);
    await databaseRef
        .collection(FirebaseKeys.messagesCollection)
        .doc(chatID)
        .collection(chatID)
        .doc(timeStamp)
        .set(chatModel.toMap());
  }

  static Future<String> uploadFile(
      {required File file, required String chatId}) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    var downloadUrl = "";
    final firebaseStorage = FirebaseStorage.instance;
    await firebaseStorage
        .ref()
        .child('chat_attachments')
        .child(chatId)
        .child(fileName)
        .putFile(file)
        .then((value) async {
      downloadUrl = await value.ref.getDownloadURL();
      return downloadUrl;
    });
    return downloadUrl;
  }
}

extension FileName on File {
  String get name {
    return path.split('/').last;
  }
}
