// methods for validating user input

String nameValidator(String value) {
  if (value.isEmpty) {
    return 'Please enter name.';
  }

  if (value.length < 3) {
    return 'Please enter a valid name.';
  }

  return null;
}

String bdayValidator(String value) {
  // TODO regex validator
  if (value.isEmpty) {
    return 'Please enter the month and year of your birth';
  }

  return null;
}

String phoneValidator(String value) {
  Pattern pattern = r'\D*([2-9]\d{2})(\D*)([2-9]\d{2})(\D*)(\d{4})\D*';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid phone number.';
  } else {
    return null;
  }
}

String altPhoneValidator(String value) {
  if (value.isEmpty) {
    return null;
  }

  Pattern pattern = r'\D*([2-9]\d{2})(\D*)([2-9]\d{2})(\D*)(\d{4})\D*';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid phone number.';
  } else {
    return null;
  }
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email.';
  } else {
    return null;
  }
}

//TODO stricter password requirements
String pwdValidator(String value) {
  if (value.length < 8) {
    return 'Password must be longer than 8 characters';
  } else {
    return null;
  }
}
