import 'common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetProfileUser extends ReduxAction<AppState> {
  final String userid;
  final String userType;

  SetProfileUser(this.userid, this.userType) : assert(userid != null);

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

  List<String> convertStringArray(List<dynamic> array) {
    if (array != null) {
      List<String> list = List<String>();
      array.forEach((element) => list.add(element.toString()));
      return list;
    }
    return null;
  }

  Client populateProfileClient(
      String userId, DocumentSnapshot basics, DocumentSnapshot specifics) {
    Client profiled = Client(userid: userId, userType: "client");

    return profiled.copy(
        name: basics["name"],
        status: basics["status"],
        bday: specifics["bday"],
        birthLocation: specifics["birthLocation"],
        birthType: specifics["birthType"],
        deliveryTypes: convertStringArray(specifics["deliveryTypes"]),
        dueDate: specifics["dueDate"],
        email: specifics["email"],
        epidural: specifics["epidural"],
        homeVisit: specifics["homeVisit"],
        liveBirths: specifics["liveBirths"],
        lowWeight: specifics["lowWeight"],
        meetBefore: specifics["meetBefore"],
        multiples: specifics["multiples"],
        phones: convertPhones(specifics["phones"]),
        photoRelease: specifics["photoRelease"]
        // emergency contacts
        // primary and backup doulas
        );
  }

  Doula populateProfileDoula(
      String userId, DocumentSnapshot basics, DocumentSnapshot specifics) {
    Doula profiled = Doula(userid: userId, userType: "doula");

    print("unav dates type: ${specifics["unavailableDates"].runtimeType}");

    return profiled.copy(
        name: basics["name"],
        status: basics["status"],
        bday: specifics["bday"],
        bio: specifics["bio"],
        birthsNeeded: specifics["birthsNeeded"],
        certInProgress: specifics["certInProgress"],
        certProgram: specifics["certProgram"],
        certified: specifics["certified"],
        email: specifics["email"],
        phones: convertPhones(specifics["phones"]),
        availableDates: convertStringArray(specifics["unavailableDates"]));
  }

  @override
  Future<AppState> reduce() async {
    Firestore fs = Firestore.instance;
    // todo handle firestore error
    DocumentSnapshot basics =
        await fs.collection("users").document(userid).get();

    DocumentSnapshot specifics = await fs
        .collection("users/$userid/userData")
        .document("specifics")
        .get();

    User profileUser;

    if (userType == "client") {
      profileUser = populateProfileClient(userid, basics, specifics);
    } else {
      profileUser = populateProfileDoula(userid, basics, specifics);
    }

    return state.copy(profileUser: profileUser);
  }
}
