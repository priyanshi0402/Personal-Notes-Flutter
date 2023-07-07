import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:personal_notes/src/model/users.dart';
import '../model/notes.dart';
import 'helper_class.dart';
import 'hive/hive_keys.dart';
import 'hive/hive_utils.dart';

class NotesHelper {
  FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> addNotesInFireStore(Notes note) async {
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;

    try {
      await databaseRef
          .collection(FirebaseKeys.notesCollection)
          .add(note.toMap())
          .then((value) {
        // final newNote = note.toMap();
        // newNote['id'] = value.id;
        // databaseRef.collection("Notes").doc(value.id).set(newNote);
        return value;
      });
    } catch (error) {
      if (error is FirebaseException) {
        print(error.message);
      }
    }
  }

  static Future<void> updateNotesInFireStore(Notes note) async {
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;
    try {
      await databaseRef
          .collection(FirebaseKeys.notesCollection)
          .doc(note.id)
          .update(note.toMap())
          .then((value) {
        return value;
      });
    } catch (error) {
      if (error is FirebaseException) {
        print(error.message);
      }
    }
  }

  static Future<List<String>> uploadFiles(
      List<String> images, String userId) async {
    var imageUrls =
        await Future.wait(images.map((images) => uploadFile(images, userId)));
    return imageUrls;
  }

  static Future<String> uploadFile(String image, String userId) async {
    // StorageReference storageReference =
    //     FirebaseStorage.instance.ref().child('posts/${_image.path}');
    // StorageUploadTask uploadTask = storageReference.putFile(_image);
    // await uploadTask.onComplete;

    final imageFile = File(image);
    var downloadUrl = "";
    final firebaseStorage = FirebaseStorage.instance;
    final name = DateTime.now().microsecondsSinceEpoch.toString();
    print("Image Name is:$name");
    await firebaseStorage
        .ref()
        .child(userId)
        .child('NotesAttachments')
        .child(name)
        .putFile(imageFile)
        .then((value) async {
      downloadUrl = await value.ref.getDownloadURL();
      return downloadUrl;
    });
    return downloadUrl;
  }

  static Future<void> deleteNotesFromDB(Notes note) async {
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;
    if (note.attachments.isEmpty) {
      await databaseRef
          .collection(FirebaseKeys.notesCollection)
          .doc(note.id)
          .delete()
          .then((value) {
        return value;
      });
    } else {
      final attachmentUrls = note.attachments.split(',');
      for (var attachmentUrl in attachmentUrls) {
        await databaseRef
            .collection(FirebaseKeys.notesCollection)
            .doc(note.id)
            .delete()
            .then((value) {
          FirebaseStorage.instance
              .refFromURL(attachmentUrl)
              .delete()
              .then((value) {
            return value;
          }).onError((error, stackTrace) {
            return value;
          });
        });
      }
    }
  }

  static Future<void> deleteAttachments(List<String> attachments) async {
    for (var attachmentUrl in attachments) {
      FirebaseStorage.instance.refFromURL(attachmentUrl).delete().then((value) {
        return value;
      });
    }
  }

  static Stream<List<Notes>> getAllNotes() {
    final userID = HiveUtils.get(HiveKeys.userId).toString();
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;

    return databaseRef
        .collection(FirebaseKeys.notesCollection)
        .where(FirebaseKeys.userId, isEqualTo: userID)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Notes.fromMap(snapshot.data()!, snapshot.id);
          },
          toFirestore: (value, options) {
            return value.toMap();
          },
        )
        .snapshots()
        .map((event) => event.docs.map((doc) => doc.data()).toList());
    // print(note.length);
    // .then((value) {
    //   notes = value.docs.map((doc) => doc.data()).toList();
    //   return notes;
    // });
    // return notes;
    // await databaseRef.collection("Notes").get().then((value) {
    //   value.docs.forEach((doc) {
    //     print(doc.data()['userId'] == userID);
    //     doc.reference;
    //   });
    // });
    // return note;
  }

  static Future<List<Notes>> getAllNotesFuture(String userID) async {
    // final userID = HiveUtils.get(HiveKeys.userId).toString();
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;
    List<Notes> notes = [];
    await databaseRef
        .collection(FirebaseKeys.notesCollection)
        // .orderBy('createdAt', descending: true)
        .where(FirebaseKeys.userId, isEqualTo: userID)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Notes.fromMap(snapshot.data()!, snapshot.id);
          },
          toFirestore: (value, options) {
            return value.toMap();
          },
        )
        .get()
        .then((value) {
          notes = value.docs.map((doc) => doc.data()).toList();
          notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return notes;
        });
    return notes;
    // await databaseRef.collection("Notes").get().then((value) {
    //   value.docs.forEach((doc) {
    //     print(doc.data()['userId'] == userID);
    //     doc.reference;
    //   });
    // });
    // return note;
  }

  static Future<List<Users>> getAllUsers() async {
    final userID = HiveUtils.get(HiveKeys.userId).toString();
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;
    List<Users> users = [];
    await databaseRef
        .collection(FirebaseKeys.usersCollection)
        .where(FirebaseKeys.userId, isNotEqualTo: userID)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Users.fromMap(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return value.toMap();
          },
        )
        .get()
        .then((value) {
          users = value.docs.map((doc) => doc.data()).toList();
        });

    return users;
  }
}
