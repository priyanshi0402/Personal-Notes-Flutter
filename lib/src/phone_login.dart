import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/src/helper/authenticate_user.dart';

import 'helper/form_validation.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key, this.isSignIn = false});
  final bool? isSignIn;

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  Country selectedCountry = Country(
      countryCode: 'IN',
      displayName: '',
      displayNameNoCountryCode: '',
      e164Key: '',
      e164Sc: 0,
      example: '',
      geographic: false,
      level: 0,
      name: '',
      phoneCode: '91');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Login')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                phoneTxtfield(),
                const SizedBox(
                  height: 20,
                ),
                doneButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneTxtfield() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        return FormValidator.numberValidator(value!);
      },
      decoration: InputDecoration(
        labelText: 'Phone Number',
        suffixIcon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.call),
        ),
        prefixIcon: SizedBox(
          width: 65,
          child: GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (value) {
                  setState(() {
                    selectedCountry = value;
                  });
                },
              );
            },
            child: Row(
              children: [
                Text(
                  selectedCountry.flagEmoji,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 5),
                Text(
                  '+${selectedCountry.phoneCode}',
                  // style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget doneButton() {
    return MaterialButton(
      onPressed: () {
        AuthenticationUser.verifyphoneNumber(
            context: context,
            phoneNumber:
                '+${selectedCountry.phoneCode} ${_phoneController.text}',
            isSignIn: widget.isSignIn ?? false);
      },
      textColor: Colors.white,
      color: Colors.deepPurple,
      minWidth: 300,
      height: 50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: const Text('Send OTP'),
    );
  }
}
