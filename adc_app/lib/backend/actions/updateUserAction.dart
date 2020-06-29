import 'package:async_redux/async_redux.dart';

import 'common.dart';

class UpdateClientUserAction extends ReduxAction<AppState> {
  final Client current;

  final String userid;
  final String userType;
  final String name;
  final List<Phone> phones;
  final String email;
  final bool phoneVerified;

  final String bday;
  final String primaryDoulaId;
  final String primaryDoulaName;
  final String backupDoulaId;
  final String backupDoulaName;
  final String dueDate;
  final String birthLocation;
  final String birthType;
  final bool epidural;
  final bool cesarean;
  final List<EmergencyContact> emergencyContacts;

  final int liveBirths;
  final bool preterm;
  final bool lowWeight;
  final List<String> deliveryTypes;
  final bool multiples;

  final bool meetBefore;
  final bool homeVisit;
  final bool photoRelease;

  UpdateClientUserAction(this.current,
      {this.userid,
      this.userType,
      this.name,
      this.phones,
      this.email,
      this.phoneVerified,
      this.bday,
      this.primaryDoulaId,
      this.primaryDoulaName,
      this.backupDoulaId,
      this.backupDoulaName,
      this.dueDate,
      this.birthLocation,
      this.birthType,
      this.epidural,
      this.cesarean,
      this.emergencyContacts,
      this.liveBirths,
      this.preterm,
      this.lowWeight,
      this.deliveryTypes,
      this.multiples,
      this.meetBefore,
      this.homeVisit,
      this.photoRelease});

  @override
  AppState reduce() {
    Client updated = current.copy(
        userid: this.userid,
        userType: this.userType,
        name: this.name,
        phones: this.phones,
        email: this.email,
        phoneVerified: this.phoneVerified,
        bday: this.bday,
        primaryDoulaId: this.primaryDoulaId,
        primaryDoulaName: this.primaryDoulaName,
        backupDoulaId: this.backupDoulaId,
        backupDoulaName: this.backupDoulaName,
        dueDate: this.dueDate,
        birthLocation: this.birthLocation,
        birthType: this.birthType,
        epidural: this.epidural,
        cesarean: this.cesarean,
        emergencyContacts: this.emergencyContacts,
        liveBirths: this.liveBirths,
        preterm: this.preterm,
        lowWeight: this.lowWeight,
        deliveryTypes: this.deliveryTypes,
        multiples: this.multiples,
        meetBefore: this.meetBefore,
        homeVisit: this.homeVisit,
        photoRelease: this.photoRelease);

    return state.copy(currentUser: updated);
  }
}

class UpdateDoulaUserAction extends ReduxAction<AppState> {
  final Doula current;

  final String userid;
  final String userType;

  final String name;
  final String email;

  final List<Phone> phones;

  final bool phoneVerified;

  final String bday;
  final bool emailVerified;

  final String bio;
  final bool certified;
  final bool certInProgress;
  final String certProgram;
  final int birthsNeeded;
  final List<String> availableDates;
  final bool photoRelease;

  final List<Client> currentClients;

  UpdateDoulaUserAction(this.current,
      {this.userid,
      this.userType,
      this.name,
      this.email,
      this.phones,
      this.phoneVerified,
      this.bday,
      this.emailVerified,
      this.bio,
      this.certified,
      this.certInProgress,
      this.certProgram,
      this.birthsNeeded,
      this.availableDates,
      this.photoRelease,
      this.currentClients});

  @override
  AppState reduce() {
    Doula updated = current.copy(
        userid: userid ?? this.userid,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        email: email ?? this.email,
        phones: phones ?? this.phones,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        bday: bday ?? this.bday,
        emailVerified: emailVerified ?? this.emailVerified,
        bio: bio ?? this.bio,
        certified: certified ?? this.certified,
        certInProgress: certInProgress ?? this.certInProgress,
        certProgram: certProgram ?? this.certProgram,
        birthsNeeded: birthsNeeded ?? this.birthsNeeded,
        availableDates: availableDates ?? this.availableDates,
        photoRelease: photoRelease ?? this.photoRelease,
        currentClients: currentClients ?? this.currentClients);
    return state.copy(currentUser: updated);
  }
}

class UpdateAdminUserAction extends ReduxAction<AppState> {
  final Admin current;

  final String userid;
  final String userType;

  final String name;
  final String email;

  final List<Phone> phones;

  final bool phoneVerified;

  final String role;
  List<String> privileges;

  UpdateAdminUserAction(this.current,
      {this.userid,
      this.userType,
      this.name,
      this.email,
      this.phones,
      this.phoneVerified,
      this.role,
      this.privileges});

  @override
  AppState reduce() {
    Admin updated = current.copy(
        userid: userid ?? this.userid,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        email: email ?? this.email,
        phones: phones ?? this.phones,
        phoneVerified: phoneVerified ?? this.phoneVerified);

    return state.copy(currentUser: updated);
  }
}

class UpdateAdminUserDocument extends ReduxAction<AppState> {
  final Admin user;

  UpdateAdminUserDocument(this.user)
      : assert(user != null && user.userType == "admin");

  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;
    await dbRef.collection("users").document(user.userid).updateData({
      "userid": user.userid,
      "name": user.name,
    });

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .updateData({
      "email": user.email,
    });

    return null;
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

class UpdateUserStatus extends ReduxAction<AppState> {
  final User profile;
  final String status;

  UpdateUserStatus(this.profile, this.status)
      : assert(profile != null && status != null);

  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;
    await dbRef.collection("users").document(profile.userid).updateData({
      "status": status,
    });

    profile.status = status;

    return state.copy(profileUser: profile);
  }
}

// assigning the primary doula only
class UpdateClientDoulas extends ReduxAction<AppState> {
  final Client client;
  final String primaryDoulaId;
  final String primaryDoulaName;

  UpdateClientDoulas(this.client, this.primaryDoulaId, this.primaryDoulaName)
      : assert(client != null);

  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;
    //Set<String> chats = state.messagesState.chats;

    // push the match to the database
    await dbRef.collection("matches").document(client.userid).setData({
      "clientName": client.name,
      "clientId": client.userid,
      "primaryDoulaId": primaryDoulaId,
      "primaryDoulaName": primaryDoulaName
    });

    // push match to client's user doc
    await dbRef
        .collection("users")
        .document(client.userid)
        .collection("userData")
        .document("specifics")
        .updateData({
      "primaryDoulaId": primaryDoulaId,
      "primaryDoulaName": primaryDoulaName
    });

    // add doula to the CLIENT's contact list
    await dbRef
        .collection("users")
        .document(client.userid)
        .collection("contacts")
        .document(primaryDoulaId)
        .setData({
      "name": primaryDoulaName,
      "userid": primaryDoulaId,
      "userType": "Doula",
      "isRecent": true
    });

    // add client to the DOULA's contact list
    await dbRef
        .collection("users")
        .document(primaryDoulaId)
        .collection("contacts")
        .document(client.userid)
        .setData({
      "name": client.name,
      "userid": client.userid,
      "userType": "Client",
      "isRecent": true
    });

    // add match locally, for display on client's profile page
    client.primaryDoulaId = primaryDoulaId;
    client.primaryDoulaName = primaryDoulaName;

    return state.copy(
        profileUser: client,
        messagesState: state.messagesState.addChat(primaryDoulaId));
  }
}

// assigning the backup doula only
class UpdateClientBackupDoula extends ReduxAction<AppState> {
  final Client client;
  final String backupDoulaId;
  final String backupDoulaName;

  UpdateClientBackupDoula(this.client, this.backupDoulaId, this.backupDoulaName)
      : assert(client != null);

  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;
    Set<String> chats = state.messagesState.chats;

    // push the match to the collection in database
    // Note: this action is always invoked after the primary doula is set
    await dbRef.collection("matches").document(client.userid).updateData(
        {"backupDoulaId": backupDoulaId, "backupDoulaName": backupDoulaName});

    // push match to client's user doc
    await dbRef
        .collection("users")
        .document(client.userid)
        .collection("userData")
        .document("specifics")
        .updateData({
      "backupDoulaId": backupDoulaId,
      "backupDoulaName": backupDoulaName
    });

    // add match locally, for display on client's profile page
    client.backupDoulaId = backupDoulaId;
    client.backupDoulaName = backupDoulaName;

    return state.copy(
        profileUser: client,
        messagesState: state.messagesState.addChat(backupDoulaId));
  }
}

class UpdateClientUserDocument extends ReduxAction<AppState> {
  UpdateClientUserDocument();

  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;

    Client user = state.currentUser as Client;

    await dbRef
        .collection("users")
        .document(user.userid)
        .updateData({"name": user.name});

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .updateData({
      "phones": phonesToDB(user.phones),
      "bday": user.bday,
      "email": user.email,
      "photoRelease": user.photoRelease,
      "emergencyContacts": emgContactsToDB(user.emergencyContacts),
      "birthLocation": user.birthLocation,
      "birthType": user.birthType,
      "dueDate": user.dueDate,
      "deliveryTypes": user.deliveryTypes,
      "preterm": user.preterm,
      "lowWeight": user.lowWeight,
      "multiples": user.multiples,
      "epidural": user.epidural,
      "cesarean": user.cesarean,
    });

    return null;
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

class UpdateDoulaUserDocument extends ReduxAction<AppState> {
  UpdateDoulaUserDocument();

  @override
  Future<AppState> reduce() async {
    Doula user = state.currentUser as Doula;
    print(
        "Attempting to update this doula ${user.toString()} to the users collection");
    final dbRef = Firestore.instance;

    await dbRef
        .collection("users")
        .document(user.userid)
        .updateData({"name": user.name});

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .updateData({
      "email": user.email,
      "phones": phonesToDB(user.phones),
      "bday": user.bday,
      "bio": user.bio,
      "photoRelease": user.photoRelease,
      "certified": user.certified,
      "certInProgress": user.certInProgress,
      "certProgram": user.certProgram,
      "birthsNeeded": user.birthsNeeded,
      "unavailableDates": user.availableDates,
    });

    return null;
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}
