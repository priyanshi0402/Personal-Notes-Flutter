import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home_page.dart';
import '../model/users.dart';
import '../phone_login.dart';
import 'helper_class.dart';
import 'hive/hive_keys.dart';
import 'hive/hive_utils.dart';

class AuthenticationUser {
  FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> signInWithGoogle({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          var userModel = Users(
            value.user?.uid ?? "",
            value.user?.displayName ?? "",
            value.user?.email ?? "",
            value.user?.photoURL ?? "",
          );
          addUserDataInFireStore(context: context, user: userModel);
        });
      } catch (error) {
        if (error is FirebaseAuthException) {
          final snackBar = SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(error.message ?? ""),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }

  static Future<void> addUserDataInFireStore(
      {required BuildContext context,
      required Users user,
      bool isUpdate = false}) async {
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;
    await databaseRef
        .collection(FirebaseKeys.usersCollection)
        .doc(user.id)
        .set(user.toMap())
        .onError((error, stackTrace) {
      if (error is FirebaseException) {
        print(error.message);
      }
    }).then((value) {
      if (isUpdate) {
        HiveUtils.set(HiveKeys.user, user.toMap());
        Navigator.pop(context);
      } else {
        HiveUtils.set(HiveKeys.userId, user.id);
        HiveUtils.set(HiveKeys.user, user.toMap());
        _navigateToHome(context);
      }
    });
  }

  static Future<void> updateUserDataInFireStore(
      {required BuildContext context, required Users user}) async {
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;
    await databaseRef
        .collection(FirebaseKeys.usersCollection)
        .doc(user.id)
        .set(user.toMap())
        .onError((error, stackTrace) {
      if (error is FirebaseException) {
        print(error.message);
      }
    }).then((value) {
      HiveUtils.set(HiveKeys.userId, user.id);
      HiveUtils.set(HiveKeys.user, user.toMap());
      _navigateToHome(context);
    });
  }

  static Future<Users?> getCurrentUserDetail({required String userId}) async {
    FirebaseFirestore databaseRef = FirebaseFirestore.instance;
    Users? user;
    await databaseRef
        .collection(FirebaseKeys.usersCollection)
        .doc(userId)
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
          user = value.data();
        });
    return user;
  }

  static Future<void> signInWithFirebase(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        User? user = value.user;
        if (user != null && user.providerData.isNotEmpty) {
          if (user.providerData.any((element) =>
              element.providerId == PhoneAuthProvider.PROVIDER_ID)) {
            var userModel = Users(user.uid, user.displayName ?? "",
                user.email ?? email, user.photoURL ?? "");
            HiveUtils.set(HiveKeys.user, userModel.toMap());
            HiveUtils.set(HiveKeys.userId, userModel.id);
            _navigateToHome(context);
            return value;
          } else {
            _navigateToPhone(context);
          }
        }
      });
    } catch (error) {
      if (error is FirebaseAuthException) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(error.message ?? ""),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  static Future<User?> signUpWithFirebase({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    User? user;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        user = value.user;
      });
    } catch (error) {
      print(error);
      if (error is FirebaseAuthException) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(error.message ?? ""),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    return user;
  }

  static Future<void> verifyphoneNumber(
      {required BuildContext context,
      required String phoneNumber,
      bool isSignIn = false}) async {
    TextEditingController codeController = TextEditingController();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        print(phoneAuthCredential);
      },
      verificationFailed: (error) {
        print(error);
      },
      codeSent: (verificationId, forceResendingToken) {
        print(verificationId);
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Enter SMS Code'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: codeController,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    final PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: codeController.text.trim());
                    print(credential);
                    if (isSignIn) {
                      FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((value) {
                        User? user = value.user;
                        if (user != null) {
                          var userModel = Users(
                              user.uid,
                              user.displayName ?? "",
                              user.email ?? "",
                              user.photoURL ?? "");
                          HiveUtils.set(HiveKeys.user, userModel.toMap());
                          HiveUtils.set(HiveKeys.userId, userModel.id);
                          _navigateToHome(context);
                        }
                      });
                    } else {
                      User? currentUser = FirebaseAuth.instance.currentUser;
                      currentUser
                          ?.updatePhoneNumber(credential)
                          .onError((error, stackTrace) {
                        print(error);
                      }).then((value) {
                        Navigator.pop(dialogContext);
                        // if (currentUser != null) {
                        var userModel = Users(
                            currentUser.uid,
                            currentUser.displayName ?? "",
                            currentUser.email ?? "",
                            currentUser.photoURL ?? "");
                        HiveUtils.set(HiveKeys.user, userModel.toMap());
                        HiveUtils.set(HiveKeys.userId, userModel.id);
                        _navigateToHome(context);
                        // }
                        // getCurrentUserDetail(userId: currentUser.uid)
                        //     .then((user) {
                        //   if (user != null) {
                        //     HiveUtils.set(HiveKeys.user, user.toMap());
                        //     HiveUtils.set(HiveKeys.userId, user.id);
                        //     _navigateToHome(context);
                        //     return value;
                        //   }
                        // });
                      });
                    }
                  },
                  child: const Text("Done"))
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  static Future<String?> uploadImageOnFirebase({
    required String userId,
    required File? imageFile,
  }) async {
    var downloadUrl = "";
    if (imageFile != null) {
      final firebaseStorage = FirebaseStorage.instance;

      await firebaseStorage
          .ref()
          .child(userId)
          .child('profie_image')
          .putFile(imageFile)
          .then((value) async {
        downloadUrl = await value.ref.getDownloadURL();
        return downloadUrl;
      });
    }
    return downloadUrl;
  }

  static Future<void> signInWithFacebook(
      {required BuildContext context}) async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile
    ]);
    switch (result.status) {
      case FacebookLoginStatus.success:
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        try {
          await FirebaseAuth.instance
              .signInWithCredential(facebookCredential)
              .then((value) {
            var userModel = Users(
              value.user?.uid ?? "",
              value.user?.displayName ?? "",
              value.user?.email ?? "",
              value.user?.photoURL ?? "",
            );
            addUserDataInFireStore(context: context, user: userModel);
          });
        } catch (error) {
          if (error is FirebaseAuthException) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(error.message ?? ""),
            );
            myAsyncMethod(context, () {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
        break;
      case FacebookLoginStatus.cancel:
        // _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        // _showErrorOnUI(result.errorMessage);
        break;
    }
  }

  static Future<void> myAsyncMethod(
      BuildContext context, VoidCallback onSuccess) async {
    await Future.delayed(const Duration(seconds: 2));
    onSuccess.call();
  }

  static void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const HomePage();
      },
    ));
  }

  static void _navigateToPhone(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const PhoneLogin();
      },
    ));
  }
}
