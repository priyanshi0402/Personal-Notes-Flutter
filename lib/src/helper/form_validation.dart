class FormValidator {
  static String? numberValidator(String text) {
    var trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return 'Please enter your number';
    }
    return null;
  }

  static String? dateValidator(String text) {
    var trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return 'Please choose your Birth Date';
    }
    return null;
  }

  static String? passwordValidator(String text) {
    var trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return 'Please enter password';
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}:"<>?\|,.]).{8,}$')
        .hasMatch(trimmedText)) {
      return 'Must have one lowercase letter, uppercase'
          ', digit, special character.';
    }
    return null;
  }

  static String? emailValidator(String text) {
    var trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(trimmedText)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? nameValidator(String text) {
    var trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return 'Please enter your name';
    } else if (text.length < 4) {
      return 'Name is too short';
    } else {
      return null;
    }
  }
}
