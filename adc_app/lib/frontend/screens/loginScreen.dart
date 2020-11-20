import './common.dart';
import '../../backend/util/timeConversion.dart';

class LoginScreen extends StatefulWidget {
  final Future<void> Function(String, String) login;
  final VoidCallback toHome;
  final VoidCallback toSignup;
  final bool isWaiting;
  final void Function() popScreen;

  LoginScreen(
      this.login, this.toHome, this.toSignup, this.isWaiting, this.popScreen);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();

  Future<void> Function(String, String) login;
  VoidCallback toHome;
  VoidCallback toSignup;
  bool isWaiting;
  void Function() popScreen;

  TextEditingController _emailInputCtrl;
  TextEditingController _pwdInputCtrl;

  bool _passwordVisible;

  @override
  void initState() {
    login = widget.login;
    toHome = widget.toHome;
    toSignup = widget.toSignup;
    isWaiting = widget.isWaiting;
    popScreen = widget.popScreen;

    _emailInputCtrl = TextEditingController();
    _pwdInputCtrl = TextEditingController();
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _emailInputCtrl.dispose();
    _pwdInputCtrl.dispose();
    super.dispose();
  }

  loginErrorDialog(BuildContext context, String cause) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text(cause),
            actions: <Widget>[
              FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    popScreen();
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log In")),
        drawer: Menu(),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: ListView(children: <Widget>[
              Text("Welcome to Atlanta Doula Connect",
                  textAlign: TextAlign.center),
              Form(
                  key: _loginFormKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "jane.doe@gmail.com",
                          icon: new Icon(Icons.mail,
                              color: themeColors["coolGray5"])),
                      controller: _emailInputCtrl,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value.isEmpty ? "Please enter email" : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "********",
                        icon: new Icon(Icons.lock,
                            color: themeColors["coolGray5"]),
                        suffixIcon: IconButton(
                          icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _passwordVisible
                                  ? themeColors["black"]
                                  : themeColors["coolGray5"]),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      controller: _pwdInputCtrl,
                      maxLines: 1,
                      obscureText: !_passwordVisible,
                      validator: (value) =>
                          value.isEmpty ? "Please enter password" : null,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          side: BorderSide(color: themeColors['yellow'])),
                      color: themeColors["yellow"],
                      textColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 20.0),
                      child: Text(
                        "LOG IN",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () async {
                        final form = _loginFormKey.currentState;
                        if (form.validate()) {
                          form.save();
                          try {
                            await login(_emailInputCtrl.text.toString().trim(),
                                _pwdInputCtrl.text.toString().trim());
                            toHome();
                          } on UserErrorException catch (e) {
                            loginErrorDialog(context, e.msg);
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Don't have an account?", textAlign: TextAlign.center),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                            side: BorderSide(color: themeColors['lightBlue'])),
                        color: themeColors["lightBlue"],
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 20.0),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () {
                          toSignup();
                        }),
                  ])),
            ])));
  }
}

class LoginScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => LoginScreen(
          vm.login, vm.toHome, vm.toSignup, vm.isWaiting, vm.popScreen),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Future<void> Function(String, String) login;
  VoidCallback toHome;
  VoidCallback toSignup;
  bool isWaiting;
  void Function() popScreen;

  ViewModel.build(
      {@required this.login,
      @required this.toHome,
      @required this.toSignup,
      @required this.isWaiting,
      @required this.popScreen})
      : super(equals: [isWaiting]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      login: (String email, String password) =>
          dispatchFuture(LoginUserAction(email, password)),
      toHome: () {
        if (state.currentUser == null) {
          dispatch(NavigateAction.pushNamed("/"));
        } else {
          switch (state.currentUser.userType) {
            case "admin":
              {
                dispatch(NavigateAction.pushNamed("/adminHome"));
              }
              break;
            case "client":
              {
                dispatch(NavigateAction.pushNamed("/clientHome"));
              }
              break;
            case "doula":
              {
                dispatch(NavigateAction.pushNamed("/doulaHome"));
              }
              break;
            default:
              {
                dispatch(NavigateAction.pushNamed("/"));
              }
              break;
          }
        }
      },
      toSignup: () => dispatch(NavigateAction.pushNamed("/signup")),
      isWaiting: state.waiting,
      popScreen: () => dispatch(NavigateAction.pop()),
    );
  }
}
