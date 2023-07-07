import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_notes/src/helper/authenticate_user.dart';
import 'package:personal_notes/src/login_page.dart';
import 'helper/form_validation.dart';
import 'dart:io';
import 'helper/hive/hive_keys.dart';
import 'helper/hive/hive_utils.dart';
import 'model/users.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, this.isMyProfile = false});
  final bool? isMyProfile;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  String? imageUrl;
  File? imageFile;
  final databaseRef = FirebaseFirestore.instance;
  final user = HiveUtils.isContainKey(HiveKeys.user)
      ? Users.fromMap((HiveUtils.get(HiveKeys.user) as Map<String, dynamic>))
      : null;

  @override
  void initState() {
    super.initState();
    if (widget.isMyProfile!) {
      _nameController.text = user?.name ?? "";
      _emailController.text = user?.email ?? "";
    }

    // _numberController.text = user?.number ?? "";
    // _dateController.text = user?.birthDate ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isMyProfile!
          ? AppBar(
              actions: [
                IconButton(onPressed: _signOut, icon: const Icon(Icons.logout))
              ],
              title: const Text('My Profile'),
            )
          : null,
      key: _scafoldKey,
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(child: _buildBody()),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      HiveUtils.remove(HiveKeys.userId);
      HiveUtils.remove(HiveKeys.user);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    });
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(top: widget.isMyProfile! ? 10.0 : 80.0),
      child: Column(
        children: [
          if (!widget.isMyProfile!) ...[
            const Text(
              'Sign Up',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.deepPurple),
            ),
          ],
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    profileImage(),
                    sizeBox(),
                    nameTextField(context),
                    emailTextField(context),
                    sizeBox(),
                    if (!widget.isMyProfile!) ...[
                      passwordTextField(context, 'Password'),
                    ],
                    sizeBox(height: 30),
                    signInButton(context),
                    sizeBox(height: 20),
                    if (!widget.isMyProfile!) ...[
                      signUpButton(context),
                    ],
                  ],
                ),
              ),
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  SizedBox sizeBox({double height = 10, double width = 0}) => SizedBox(
        height: height,
        width: width,
      );

  TextFormField nameTextField(BuildContext context) {
    return TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          return FormValidator.nameValidator(value!);
        },
        decoration: const InputDecoration(
            labelText: 'Full Name',
            suffixIcon: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.person),
            )));
  }

  TextFormField emailTextField(BuildContext context) {
    return TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        readOnly: widget.isMyProfile!,
        validator: (value) {
          return FormValidator.emailValidator(value!);
        },
        decoration: const InputDecoration(
            labelText: 'Email',
            suffixIcon: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.email),
            )));
  }

  TextFormField passwordTextField(BuildContext context, String text) {
    return TextFormField(
      // onChanged: (text) => setState(() => password = text),
      controller: _passwordController,
      decoration: InputDecoration(
          labelText: text,
          suffixIcon: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.remove_red_eye_outlined),
          )),
      validator: (value) {
        return FormValidator.passwordValidator(value!);
      },
      obscureText: true,
    );
  }

  Widget signInButton(BuildContext context) {
    return MaterialButton(
      onPressed: _signUpClicked,
      textColor: Colors.white,
      color: Colors.deepPurple,
      minWidth: 300,
      height: 50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(widget.isMyProfile! ? 'Save' : 'Sign up'),
    );
  }

  Widget signUpButton(BuildContext context) {
    return TextButton(
        onPressed: _signInClicked,
        child: const Text("Have an account? Sign In",
            style: TextStyle(color: Colors.black)));
  }

  void _signUpClicked() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (widget.isMyProfile!) {
        if (imageFile == null) {
          var userModel = Users(
            user?.id ?? "",
            _nameController.text,
            user?.email ?? "",
            user?.profileImage ?? "",
          );
          addDataInFirebase(userModel: userModel, isUpdate: true);
        } else {
          AuthenticationUser.uploadImageOnFirebase(
                  userId: user?.id ?? "", imageFile: imageFile)
              .then((file) {
            var userModel = Users(
              user?.id ?? "",
              _nameController.text,
              user?.email ?? "",
              file ?? "",
            );
            addDataInFirebase(userModel: userModel, isUpdate: true);
          });
        }
      } else {
        AuthenticationUser.signUpWithFirebase(
                context: context,
                email: _emailController.text,
                password: _passwordController.text)
            .then((user) {
          user?.updateDisplayName(_nameController.text);
          if (imageFile == null) {
            var userModel = Users(
              user?.uid ?? "",
              _nameController.text,
              user?.email ?? "",
              "",
            );
            addDataInFirebase(userModel: userModel);
          } else {
            AuthenticationUser.uploadImageOnFirebase(
                    userId: user?.uid ?? "", imageFile: imageFile)
                .then((file) {
              user?.updatePhotoURL(file);
              var userModel = Users(
                user?.uid ?? "",
                _nameController.text,
                user?.email ?? "",
                file ?? "",
              );
              addDataInFirebase(userModel: userModel);
            });
          }
          print(user);
        });
      }

      // signUpWithFirebase();
    }
  }

  Future<void> addDataInFirebase(
      {required Users userModel, bool isUpdate = false}) {
    return AuthenticationUser.addUserDataInFireStore(
            context: context, user: userModel, isUpdate: isUpdate)
        .whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _signInClicked() {
    Navigator.pop(context);
  }

  Widget profileImage() {
    return GestureDetector(
        onTap: () {
          _openActionSheet();
        },
        child: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(40), // Image radius
            child: setupImage(),
          ),
        ));
  }

  void _openActionSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              title: const Text('Choose Image'),
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {}, child: const Text('Camera')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, 'Camera');
                      _openPhotosImagePicker();
                    },
                    child: const Text('Photos')),
              ],
              cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Cancel')),
            ));
  }

  void _openPhotosImagePicker() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
      }
    });
    print(pickedImage?.path ?? 'error ');
  }

  Widget setupImage() {
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: BoxFit.cover,
      );
    } else if ((user?.profileImage ?? "").isEmpty) {
      return Container(
        color: Colors.deepPurple[400],
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      );
    } else {
      return Image.network(
        user?.profileImage ?? "",
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator.adaptive(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );

      // FadeInImage.assetNetwork(
      //   placeholder: 'assets/images/facebook.jpg',
      //   image: user?.profileImage ?? "",
      //   fit: BoxFit.cover,
      // );
    }
  }
}
