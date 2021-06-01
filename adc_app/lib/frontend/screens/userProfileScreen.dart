import 'common.dart';

// Profile screen of ANOTHER user

class UserProfileScreen extends StatefulWidget {
  final User profileUser;
  final VoidCallback toDoulasListMatching;
  final Future<void> Function(User, String) changeStatus;
  // determines what part of another user's profile they can view/interact with
  // if profileUser.userid == currentUser.userid then user is viewing their own
  // profile and can edit it
  final User currentUser;

  UserProfileScreen(this.changeStatus, this.profileUser, this.currentUser,
      this.toDoulasListMatching)
      : assert(profileUser != null && currentUser != null);

  @override
  State<StatefulWidget> createState() {
    return UserProfileScreenState(toDoulasListMatching);
  }
}

class UserProfileScreenState extends State<UserProfileScreen> {
  User profileUser;
  User currentUser;
  Future<void> Function(User, String) changeStatus;
  bool userApproved;
  bool userHasDoula;
  bool userHasBackupDoula;
  final VoidCallback toDoulasListMatching;

  UserProfileScreenState(this.toDoulasListMatching);

  @override
  void initState() {
    profileUser = widget.profileUser;
    currentUser = widget.currentUser;
    changeStatus = widget.changeStatus;
    userApproved = profileUser.status != 'submitted';
    userHasDoula = (profileUser is Client)
        ? (profileUser as Client).primaryDoulaId != null
        : null;
    userHasBackupDoula = (profileUser is Client)
        ? (profileUser as Client).backupDoulaId != null
        : null;
    super.initState();
  }

  String boolStr(bool value) {
    if (value == null) {
      return "No Response";
    }
    if (value) return "Yes";
    return "No";
  }

  ListView adminUser() {
    if (profileUser.userType == "doula") {
      String phonesString = profileUser.phones.join(", ");
      Doula profileUserDoula = profileUser;
      String availableDates = profileUserDoula.availableDates != null
          ? profileUserDoula.availableDates.join(", ")
          : "(no dates selected)";

      return ListView(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 30.0, bottom: 10.0, right: 5.0, left: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: themeColors["black"],
                        ),
                      ),
                      child: Icon(
                        IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: 90,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        profileUser.name,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userApproved ? "Approved" : "Not Approved",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: themeColors['black'],
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            height: 1.5),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Visibility(
                    visible: !userApproved,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: themeColors['emoryBlue'])),
                      onPressed: () async {
                        await changeStatus(profileUserDoula, 'approved');
                        setState(() {
                          userApproved = profileUser.status != 'submitted';
                        });
                      },
                      color: themeColors['emoryBlue'],
                      textColor: Colors.black,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['emoryBlue'],
                      child: Text(
                        "Approve User",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: themeColors['white'],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Personal Information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Name: ${profileUser.name}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Email: ${profileUser.email}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Phone(s): $phonesString',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Birthday (MM/YYYY): ${profileUserDoula.bday}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Short Bio',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${profileUserDoula.bio}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),

                // AVAILABILITY
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Availability',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'I am not availabe on: $availableDates',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                // CERTIFICATION STATUS
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Certification Status',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Certified? ${boolStr(profileUserDoula.certified)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Working towards Certification? ${boolStr(profileUserDoula.certInProgress)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Certification Program: ${profileUserDoula.certProgram}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Number of documented births needed for certification: ${profileUserDoula.birthsNeeded}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${boolStr(profileUserDoula.photoRelease)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      String phonesString = profileUser.phones.join(", ");
      Client profileUserClient = profileUser;
      String deliveryTypes = "";
      if (profileUserClient.deliveryTypes != null) {
        deliveryTypes = profileUserClient.deliveryTypes.join(", ");
      }
      String emergencyContacts = "";
      if (profileUserClient.emergencyContacts != null) {
        emergencyContacts = profileUserClient.emergencyContacts.join("\n");
      }

      return ListView(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 30.0, bottom: 10.0, right: 5.0, left: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: themeColors["black"],
                        ),
                      ),
                      child: Icon(
                        IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: 90,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        profileUser.name,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userApproved ? "Approved" : "Not Approved",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: themeColors['black'],
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            height: 1.5),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Visibility(
                    visible: !userApproved,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: themeColors['emoryBlue'])),
                      onPressed: () async {
                        await changeStatus(profileUserClient, 'approved');
                        setState(() {
                          userApproved = profileUser.status == 'approved';
                        });
                      },
                      color: themeColors['emoryBlue'],
                      textColor: Colors.black,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['emoryBlue'],
                      child: Text(
                        "Approve User",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: themeColors['white'],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text(
                  userHasDoula
                      ? 'Assigned Doula: ${profileUserClient.primaryDoulaName}'
                      : 'No Primary Doula Assigned',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Visibility(
                  visible: userApproved && !userHasDoula,
                  child: Text(
                    '',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 12,
                        height: 1.0),
                    textAlign: TextAlign.left,
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: userApproved && !userHasDoula,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: themeColors['emoryBlue'])),
                      onPressed: () async {
                        //TODO: need to show doulas and store selected assignment
                        setState(() {
                          toDoulasListMatching();
                          userHasDoula =
                              profileUserClient.primaryDoulaId != null;
                        });
                      },
                      color: themeColors['emoryBlue'],
                      textColor: Colors.black,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['emoryBlue'],
                      child: Text(
                        "Assign Doula",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: themeColors['white'],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text(
                  userHasBackupDoula
                      ? 'Assigned Backup Doula: ${profileUserClient.backupDoulaName}'
                      : 'No Backup Doula Assigned',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Visibility(
                  visible: userApproved && userHasDoula && !userHasBackupDoula,
                  child: Text(
                    '',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 12,
                        height: 1.0),
                    textAlign: TextAlign.left,
                  ),
                ),
                Center(
                  child: Visibility(
                    visible:
                        userApproved && userHasDoula && !userHasBackupDoula,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: themeColors['emoryBlue'])),
                      onPressed: () async {
                        //TODO: need to show doulas and store selected assignment
                        setState(() {
                          toDoulasListMatching();
                          userHasBackupDoula =
                              profileUserClient.backupDoulaId != null;
                        });
                      },
                      color: themeColors['emoryBlue'],
                      textColor: Colors.black,
                      padding: EdgeInsets.all(15.0),
                      splashColor: themeColors['emoryBlue'],
                      child: Text(
                        "Assign Doula",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: themeColors['white'],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Personal Information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Name: ${profileUserClient.name}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Email: ${profileUserClient.email}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Phone(s): $phonesString',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Birthday (MM/YYYY): ${profileUserClient.bday}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // EMERGENCY CONTACTS

                Text('Emergency Contacts',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "$emergencyContacts",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                // CURRENT PREGNANCY DETAILS

                Text('Current Pregnancy Details',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Due date: ${profileUserClient.dueDate}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Planned Birth Location: ${profileUserClient.birthLocation}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Birth Types: ${profileUserClient.birthType}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // PREVIOUS BIRTH DETAILS

                Text('Previous Birth Details',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Number of Previous Live Births: ${profileUserClient.liveBirths}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous preterm baby? ${boolStr(profileUserClient.preterm)}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous low weight baby? ${boolStr(profileUserClient.lowWeight)}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous birth methods: $deliveryTypes",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // DOULA PREFERENCES
                Text('Doula Preferences',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Meet doula before birth?: ${boolStr(profileUserClient.meetBefore)}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Doula post birth home visit?: ${boolStr(profileUserClient.homeVisit)}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // PHOTO RELEASE

                Text('Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${boolStr(profileUserClient.photoRelease)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  ListView clientUser() {
    if (profileUser.userType == "client") {
      String phonesString = profileUser.phones.join(", ");
      Client profileUserClient = profileUser;
      String deliveryTypes = "";
      if (profileUserClient.deliveryTypes != null) {
        deliveryTypes = profileUserClient.deliveryTypes.join(", ");
      }
      String emergencyContacts = "";
      if (profileUserClient.emergencyContacts != null) {
        emergencyContacts = profileUserClient.emergencyContacts.join("\n");
      }

      return ListView(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 30.0, bottom: 10.0, right: 5.0, left: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: themeColors["black"],
                        ),
                      ),
                      child: Icon(
                        IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: 90,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        profileUser.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userApproved ? "Approved" : "Not Approved",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: themeColors['black'],
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            height: 1.5),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userHasDoula
                      ? 'Assigned Doula: ${profileUserClient.primaryDoulaName}'
                      : 'No Primary Doula Assigned',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                //              Text(
                //                '',
                //                style: TextStyle(
                //                    fontFamily: 'Roboto',
                //                    color: themeColors['black'],
                //                    fontSize: 12,
                //                    height: 1.0),
                //                textAlign: TextAlign.left,
                //              ),
                //              Text(
                //                userHasBackupDoula
                //                    ? 'Assigned Backup Doula: ${profileUserClient.backupDoula["name"]}'
                //                    : 'No Backup Doula Assigned',
                //                style: TextStyle(
                //                    fontFamily: 'Roboto',
                //                    color: themeColors['black'],
                //                    fontSize: 18,
                //                    height: 1.5),
                //                textAlign: TextAlign.left,
                //              ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Personal Information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Name: ${profileUserClient.name}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Email: ${profileUserClient.email}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Phone(s): $phonesString',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Birthday (MM/YYYY): ${profileUserClient.bday}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // EMERGENCY CONTACTS

                Text('Emergency Contacts',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "$emergencyContacts",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                // CURRENT PREGNANCY DETAILS

                Text('Current Pregnancy Details',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Due date: ${profileUserClient.dueDate}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Planned Birth Location: ${profileUserClient.birthLocation}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Birth Types: ${profileUserClient.birthType}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // PREVIOUS BIRTH DETAILS

                Text('Previous Birth Details',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Number of Previous Live Births: ${profileUserClient.liveBirths}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous preterm baby? ${boolStr(profileUserClient.preterm)}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous low weight baby? ${boolStr(profileUserClient.lowWeight)}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous birth methods: $deliveryTypes",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // DOULA PREFERENCES
                Text('Doula Preferences',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Meet doula before birth?: ${boolStr(profileUserClient.meetBefore)}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Doula post birth home visit?: ${boolStr(profileUserClient.homeVisit)}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // PHOTO RELEASE

                Text('Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${boolStr(profileUserClient.photoRelease)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      String phonesString = profileUser.phones.join(", ");
      Doula profileUserDoula = profileUser;
      String availableDates = profileUserDoula.availableDates != null
          ? profileUserDoula.availableDates.join(", ")
          : "(no dates selected)";

      return ListView(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 30.0, bottom: 10.0, right: 5.0, left: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: themeColors["black"],
                        ),
                      ),
                      child: Icon(
                        IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: 90,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        profileUser.name,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userApproved ? "Approved" : "Not Approved",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: themeColors['black'],
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            height: 1.5),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Personal Information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Name: ${profileUser.name}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Email: ${profileUser.email}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Phone(s): $phonesString',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Birthday (MM/YYYY): ${profileUserDoula.bday}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Short Bio',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${profileUserDoula.bio}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),

                // AVAILABILITY
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Availability',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'I am not availabe on: $availableDates',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                // CERTIFICATION STATUS
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Certification Status',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Certified? ${boolStr(profileUserDoula.certified)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Working towards Certification? ${boolStr(profileUserDoula.certInProgress)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Certification Program: ${profileUserDoula.certProgram}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Number of documented births needed for certification: ${profileUserDoula.birthsNeeded}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${boolStr(profileUserDoula.photoRelease)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  ListView doulaUser() {
    if (profileUser.userType == "doula") {
      String phonesString = profileUser.phones.join(", ");
      Doula profileUserDoula = profileUser;
      String availableDates = profileUserDoula.availableDates != null
          ? profileUserDoula.availableDates.join(", ")
          : "(no dates selected)";

      return ListView(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 30.0, bottom: 10.0, right: 5.0, left: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: themeColors["black"],
                        ),
                      ),
                      child: Icon(
                        IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: 90,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        profileUser.name,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userApproved ? "Approved" : "Not Approved",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: themeColors['black'],
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            height: 1.5),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Personal Information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Name: ${profileUser.name}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Email: ${profileUser.email}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Phone(s): $phonesString',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Birthday (MM/YYYY): ${profileUserDoula.bday}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Short Bio',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${profileUserDoula.bio}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),

                // AVAILABILITY
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Availability',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'I am not availabe on: $availableDates',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                // CERTIFICATION STATUS
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Certification Status',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Certified? ${boolStr(profileUserDoula.certified)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Working towards Certification? ${boolStr(profileUserDoula.certInProgress)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Certification Program: ${profileUserDoula.certProgram}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Number of documented births needed for certification: ${profileUserDoula.birthsNeeded}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                Text('Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${boolStr(profileUserDoula.photoRelease)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      String phonesString = profileUser.phones.join(", ");
      Client profileUserClient = profileUser;
      String deliveryTypes = "";
      if (profileUserClient.deliveryTypes != null) {
        deliveryTypes = profileUserClient.deliveryTypes.join(", ");
      }
      String emergencyContacts = "";
      if (profileUserClient.emergencyContacts != null) {
        emergencyContacts = profileUserClient.emergencyContacts.join("\n");
      }

      return ListView(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 30.0, bottom: 10.0, right: 5.0, left: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: themeColors["black"],
                        ),
                      ),
                      child: Icon(
                        IconData(0xe7fd, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: 90,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        profileUser.name,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userApproved ? "Approved" : "Not Approved",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: themeColors['black'],
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            height: 1.5),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Personal Information',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  'Name: ${profileUserClient.name}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Email: ${profileUserClient.email}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Phone(s): $phonesString',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Birthday (MM/YYYY): ${profileUserClient.bday}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // EMERGENCY CONTACTS

                Text('Emergency Contacts',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "$emergencyContacts",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),
                // CURRENT PREGNANCY DETAILS

                Text('Current Pregnancy Details',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Due date: ${profileUserClient.dueDate}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Planned Birth Location: ${profileUserClient.birthLocation}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Birth Types: ${profileUserClient.birthType}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // PREVIOUS BIRTH DETAILS

                Text('Previous Birth Details',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Number of Previous Live Births: ${profileUserClient.liveBirths}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous preterm baby? ${boolStr(profileUserClient.preterm)}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous low weight baby? ${boolStr(profileUserClient.lowWeight)}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: profileUserClient.liveBirths > 0,
                  child: Text(
                    "Previous birth methods: $deliveryTypes",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['black'],
                        fontSize: 18,
                        height: 1.5),
                    textAlign: TextAlign.left,
                  ),
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // DOULA PREFERENCES
                Text('Doula Preferences',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  "Meet doula before birth?: ${boolStr(profileUserClient.meetBefore)}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Doula post birth home visit?: ${boolStr(profileUserClient.homeVisit)}",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 12,
                      height: 1.0),
                  textAlign: TextAlign.left,
                ),

                // PHOTO RELEASE

                Text('Photo Release',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['emoryBlue'],
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left),
                Text(
                  '${boolStr(profileUserClient.photoRelease)}',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: themeColors['black'],
                      fontSize: 18,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  // does a user get a profile when they haven't chosen a user type yet?

  @override
  Widget build(BuildContext context) {
    ListView listview;

    String userType = currentUser != null ? currentUser.userType : "null";
    String title = "Profile";

    switch (userType) {
      case "admin":
        {
          listview = adminUser();
          title = profileUser.name + "'s Profile";
        }
        break;
      case "client":
        {
          listview = clientUser();
          if (profileUser.userid == currentUser.userid) {
            title = "Your Profile";
          } else {
            title = "Your Doula's Profile";
          }
        }
        break;
      case "doula":
        {
          listview = doulaUser();
          if (profileUser.userid == currentUser.userid) {
            title = "Your Profile";
          } else {
            title = profileUser.name + "'s Profile";
          }
        }
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(12.0), child: listview),
      ),
    );
  }
}

class UserProfileScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        model: ViewModel(),
        builder: (BuildContext context, ViewModel vm) => UserProfileScreen(
            vm.changeStatus,
            vm.profileUser,
            vm.currentUser,
            vm.toDoulasListMatching));
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  VoidCallback toDoulasListMatching;

  User profileUser;
  User currentUser;
  Future<void> Function(User, String) changeStatus;

  ViewModel.build(
      {@required this.profileUser,
      @required this.currentUser,
      @required this.changeStatus,
      @required this.toDoulasListMatching})
      : super(equals: [profileUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      profileUser: state.profileUser,
      currentUser: state.currentUser,
      toDoulasListMatching: () =>
          dispatch(NavigateAction.pushReplacementNamed("/doulasListMatching")),
      changeStatus: (User profile, String status) =>
          dispatchFuture(UpdateUserStatus(profile, status)),
    );
  }
}
