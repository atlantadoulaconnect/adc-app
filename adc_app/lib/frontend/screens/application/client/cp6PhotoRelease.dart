import '../../common.dart';

class Cp6PhotoRelease extends StatefulWidget {
  final Client currentUser;
  final void Function(bool) updateClient;
  final VoidCallback toCp7Confirmation;
  final void Function(bool) cancelApplication;

  Cp6PhotoRelease(this.currentUser, this.updateClient, this.toCp7Confirmation,
      this.cancelApplication)
      : assert(currentUser != null &&
            currentUser.userType == "client" &&
            updateClient != null &&
            toCp7Confirmation != null &&
            cancelApplication != null);

  @override
  State<StatefulWidget> createState() {
    return Cp6PhotoReleaseState();
  }
}

class Cp6PhotoReleaseState extends State<Cp6PhotoRelease> {
  Client currentUser;
  void Function(bool) updateClient;
  VoidCallback toCp7Confirmation;
  void Function(bool) cancelApplication;

  bool statementAgree;

  @override
  void initState() {
    currentUser = widget.currentUser;
    updateClient = widget.updateClient;
    toCp7Confirmation = widget.toCp7Confirmation;
    cancelApplication = widget.cancelApplication;

    initialPlaceholders();

    super.initState();
  }

  void initialPlaceholders() {
    statementAgree =
        currentUser.photoRelease == null || !currentUser.photoRelease
            ? false
            : true;
  }

  confirmCancelDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Cancel Application"),
          content: Text("Do you want to cancel your application?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                //dispatch CancelApplication
                cancelApplication(true);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                cancelApplication(false);
              },
            )
          ],
        );
      },
    );
  }

  void saveValidInputs() {
    updateClient(statementAgree);
  }

  Future<bool> _onBackPressed() {
    saveValidInputs();
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(title: Text("Request a Doula")),
            body: Center(
                child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Photo Release',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: themeColors['emoryBlue'],
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                    child: LinearProgressIndicator(
                      backgroundColor: themeColors['skyBlue'],
                      valueColor: AlwaysStoppedAnimation<Color>(
                          themeColors['mediumBlue']),
                      value: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Please read the following statements: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      'I, grant the Urban Health Initiative of Emory Photo/Video '
                      'permission to use any photographs in Emory’s own publications or in any other broadcast'
                      ',print,  or  electronic  media,  including—without  limitation—newspaper, radio,  '
                      'television,  magazine,  internet.  I  waive  any  right  to  inspect  or  approve  my  depictions'
                      '  in  these  works.     '),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      'I  agree  that  Emory  University  may  use  such  photographs  of  me  '
                      'and my infant with  or  without  my  name  and  for  any  lawful  purpose,  '
                      'including  for  example  such  purposes  as  publicity,  illustration,  '
                      'advertising,  and  Web  content.  '),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: statementAgree,
                        onChanged: (bool value) {
                          setState(() {
                            statementAgree = value;
                          });
                        },
                      ),
                      Text("I agree to the statements above (optional) ")
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: themeColors['lightBlue'])),
                        onPressed: () {
                          saveValidInputs();

                          Navigator.pop(context);
                        },
                        color: themeColors['lightBlue'],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        splashColor: themeColors['lightBlue'],
                        child: Text(
                          "PREVIOUS",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: themeColors['coolGray5'])),
                        onPressed: () {
                          // dialog to confirm cancellation
                          confirmCancelDialog(context);
                        },
                        color: themeColors['coolGray5'],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        splashColor: themeColors['coolGray5'],
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: themeColors['black'],
                          ),
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(color: themeColors['yellow'])),
                        onPressed: () {
                          updateClient(statementAgree);

                          toCp7Confirmation();
                        },
                        color: themeColors['yellow'],
                        textColor: Colors.black,
                        padding: EdgeInsets.all(15.0),
                        splashColor: themeColors['yellow'],
                        child: Text(
                          "NEXT",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ]),
              ],
            ))));
  }
}

class Cp6PhotoReleaseConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => Cp6PhotoRelease(
          vm.currentUser,
          vm.updateClient,
          vm.toCp7Confirmation,
          vm.cancelApplication),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  void Function(bool) updateClient;
  VoidCallback toCp7Confirmation;
  void Function(bool) cancelApplication;

  ViewModel.build(
      {@required this.currentUser,
      @required this.updateClient,
      @required this.toCp7Confirmation,
      @required this.cancelApplication})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      toCp7Confirmation: () =>
          dispatch(NavigateAction.pushNamed("/cp7Confirmation")),
      updateClient: (bool photoRelease) =>
          dispatch(UpdateClientUserAction(photoRelease: photoRelease)),
      cancelApplication: (bool confirmed) {
        dispatch(NavigateAction.pop());
        if (confirmed) {
          dispatch(CancelApplicationAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        }
      },
//        completePage: (String pageName) =>
//            dispatch(CompletePageAction(pageName))
    );
  }
}
