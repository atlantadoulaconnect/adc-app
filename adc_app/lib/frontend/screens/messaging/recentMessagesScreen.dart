import '../common.dart';
//import 'package:url_launcher/url_launcher.dart';

class RecentMessagesScreen extends StatelessWidget {
  final User currentUser;

  // TODO messages page corresponds to card
  final VoidCallback toMessages;
  final VoidCallback toContacts;

  RecentMessagesScreen(this.currentUser, this.toMessages, this.toContacts);

  @override
  Widget build(BuildContext context) {
    final recentContacts = ["Debbie D.", "Sandra D.", "Contact Support"];
    final recentMessage = ["What do you think abo...", "", ""];
    final contactCards = <Widget>[];
    for (var i = 0; i < recentContacts.length; i++) {
      contactCards.add(
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Container(
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                width: 2.0,
              )),
              child: MaterialButton(
                onPressed: () => toMessages(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          width: 45,
                          height: 45,
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
                            size: 35,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14.0, right: 12.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                recentContacts[i],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                recentContacts[i] == "Contact Support"
                                    ? "Admin"
                                    : "Doula",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                recentMessage[i],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: themeColors["coolGray5"]),
                              ),
                            ]),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 17.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2.0,
                              color: themeColors["black"],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: themeColors["black"]),
                            ),
                          ),
                        ),
                      ),
                    ]),
              )),
        ),
      );
    }
    final number = "911";
    contactCards.add(Spacer());
    contactCards.add(
      Padding(
        padding: EdgeInsets.only(bottom: 35.0),
        child: Container(
          height: 60,
          child: MaterialButton(
            //onPressed: () => launch("tel:$number"),
            onPressed: () {},
            color: themeColors["yellow"],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(color: themeColors['yellow'])),
            child: Text(
              "CALL 911",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: themeColors["emoryBlue"],
              ),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Recent Messages'),
          actions: <Widget>[
            Container(
              width: 55,
              child: MaterialButton(
                onPressed: () => toContacts(),
                child: Icon(
                  IconData(0xe150, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        drawer: Menu(),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: contactCards,
            )));
  }
}

class RecentMessagesScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return RecentMessagesScreen(
            vm.currentUser, vm.toMessages, vm.toContacts);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  User currentUser;
  VoidCallback toMessages;
  VoidCallback toContacts;

  ViewModel.build(
      {@required this.currentUser,
      @required this.toMessages,
      @required this.toContacts})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        toMessages: () => dispatch(NavigateAction.pushNamed("/messages")),
        toContacts: () => dispatch(NavigateAction.pushNamed("/contacts")));
  }
}
