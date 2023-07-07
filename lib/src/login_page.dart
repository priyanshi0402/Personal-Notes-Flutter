import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/src/helper/authenticate_user.dart';
import 'package:personal_notes/src/phone_login.dart';
import 'package:personal_notes/src/signup_page.dart';
import 'helper/form_validation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final databaseRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: const Text('Login'),
      // ),
      body: SingleChildScrollView(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          const Text(
            'Sign In',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    emailTextField(context),
                    sizeBox(),
                    passwordTextField(context, 'Password'),
                    sizeBox(height: 30),
                    signInButton(context),
                    sizeBox(height: 20),
                    signUpButton(context),
                    sizeBox(),
                    orLabel(context),
                    sizeBox(height: 20),
                    thirdPartyLoginButtons()
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

  TextFormField emailTextField(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return FormValidator.emailValidator(value!);
      },
      decoration: const InputDecoration(
        labelText: 'Email',
        suffixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.email),
        ),
      ),
    );
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
      onPressed: _signInClicked,
      textColor: Colors.white,
      color: Colors.deepPurple,
      minWidth: 300,
      height: 50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: const Text('Sign in'),
    );
  }

  Widget signUpButton(BuildContext context) {
    return TextButton(
        onPressed: _signUpClicked,
        child: const Text("Don't have an account?",
            style: TextStyle(color: Colors.black)));
  }

  Widget orLabel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 1,
          color: Colors.grey,
        ),
        sizeBox(width: 10),
        const Text("or"),
        sizeBox(width: 10),
        Container(
          width: 100,
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget thirdPartyLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: IconButton(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              // iconSize: 50,
              onPressed: signInWithFacebook,
              icon: Image.asset(
                'assets/images/facebook.png',
                height: 25,
              )),
        ),
        sizeBox(width: 20),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: IconButton(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              // iconSize: 50,
              onPressed: signInWithGoogle,
              icon: Image.asset(
                'assets/images/google.png',
                height: 25,
              )),
        ),
        sizeBox(width: 20),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: IconButton(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              // iconSize: 50,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const PhoneLogin(
                      isSignIn: true,
                    );
                  },
                ));
              },
              icon: const Icon(Icons.call)),
        )
      ],
    );
  }

  void _signInClicked() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      AuthenticationUser.signInWithFirebase(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      ).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _signUpClicked() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const SignUpPage();
      },
    ));
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    AuthenticationUser.signInWithGoogle(context: context).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> signInWithFacebook() async {
    setState(() {
      _isLoading = true;
    });
    AuthenticationUser.signInWithFacebook(context: context).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
