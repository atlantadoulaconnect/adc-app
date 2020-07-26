import '../states/common.dart';

// methods for validating user input
String nameValidator(String value) {
  if (value.isEmpty) {
    return 'Please enter name';
  }

  if (value.length < 3) {
    return 'Please enter a valid name';
  }

  return null;
}

String singleLetterValidator(String value) {
  Pattern pattern = r'[a-zA-Z]';
  RegExp regex = RegExp(pattern);
  if (value.length != 1) {
    return "Enter last initial";
  }
  if (!regex.hasMatch(value)) {
    return "Enter last initial";
  }
  return null;
}

String bioValidator(String value) {
  Pattern pattern = r'[a-zA-Z]+';
  RegExp regex = RegExp(pattern);
  if (value.isEmpty) {
    return "Please enter text";
  }
  if (!regex.hasMatch(value)) {
    return "Enter word";
  }
  return null;
}

String bdayValidator(String value) {
  // TODO regex validator, no input too far back
  if (value.isEmpty) {
    return 'Please enter the month and year of your birth';
  }

  return null;
}

String phoneValidator(String value) {
  Pattern pattern = r'\D*([2-9]\d{2})(\D*)([2-9]\d{2})(\D*)(\d{4})\D*';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value.length != 10) {
    return 'Please enter a valid phone number';
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
    return 'Please enter a valid phone number';
  } else {
    return null;
  }
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email';
  } else {
    return null;
  }
}

//TODO stricter password requirements
String pwdValidator(String value) {
  if (value.length < 8) {
    return 'Password must be longer than 8 characters';
  } else {
    if (value.contains(new RegExp('[0-9]'),0) == false) {
      return 'Password must contain at least one number';
    } else if (value.contains(new RegExp('[^a-zA-Z0-9]'),0) == false) {
      return 'Password must contain at least one character';
    } else {
      return null;
    }
  }

}

// Methods for safely transferring data between app and db
Map<String, String> convertDoulaMap(Map<dynamic, dynamic> doula) {
  if (doula != null) {
    return {"name": doula["name"], "userid": doula["userid"]};
  }
  return null;
}

// db -> app
List<String> convertStringArray(List<dynamic> array) {
  if (array != null) {
    List<String> list = List<String>();
    array.forEach((element) => list.add(element.toString()));
    return list;
  }
  return null;
}

Set<String> convertStringSet(List<dynamic> array) {
  if (array != null) {
    Set<String> set = Set<String>();
    array.forEach((element) => set.add(element.toString()));
    return set;
  }
  return null;
}

List<Map<String, dynamic>> phonesToDB(List<Phone> phones) {
  List<Map<String, dynamic>> array = List();
  if (phones != null && phones.length > 0) {
    // sanity check
    phones.forEach((phone) {
      array.add({"number": phone.number, "isPrimary": phone.isPrimary});
    });
    return array;
  }
  return null;
}

List<Phone> convertPhones(List<dynamic> phoneList) {
  List<Phone> phones = List<Phone>();

  if (phoneList != null) {
    if (phoneList.length > 0) {
      phoneList.forEach((element) {
        phones.add(Phone(element["number"].toString(), element["isPrimary"]));
      });
    }
  }
  return phones;
}

// emergency contacts -> firestore safe data structure
List<Map<String, dynamic>> emgContactsToDB(List<EmergencyContact> ecs) {
  List<Map<String, dynamic>> array = List();
  if (ecs != null && ecs.length > 0) {
    // sanity check
    ecs.forEach((ec) {
      array.add({
        "name": ec.name,
        "relationship": ec.relationship,
        "phones": phonesToDB(ec.phones)
      });
    });
    return array;
  }
  return null;
}

List<EmergencyContact> convertEmgContacts(List<dynamic> ecList) {
  List<EmergencyContact> emgContacts = List();

  if (ecList != null && ecList.length > 0) {
    ecList.forEach((ec) {
      emgContacts.add(EmergencyContact(ec["name"].toString(),
          ec["relationship"].toString(), convertPhones(ec["phones"])));
    });
    return emgContacts;
  }
  return null;
}

String getFirstName(String full) {
  if (full.contains(" ")) {
    List<String> names = full.split(" ");
    return names.sublist(0, names.length - 1).join(" ");
  }
  // no space in name = only first name
  return full;
}

String getLastInitial(String full) {
  if (full.contains(" ")) {
    List<String> names = full.split(" ");
    return names[names.length - 1].substring(0, 1);
  }

  // no space in name = only first name; return empty string for last initial
  return null;
}
