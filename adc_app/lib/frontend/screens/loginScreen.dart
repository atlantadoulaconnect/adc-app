import './common.dart';
import '../../backend/util/timeConversion.dart';

class LoginScreen extends StatefulWidget {
  final Future<void> Function(String, String) login;
  final VoidCallback toHome;
  final VoidCallback toSignup;
  final bool isWaiting;

  LoginScreen(this.login, this.toHome, this.toSignup, this.isWaiting);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();

  Future<void> Function(String, String) login;
  VoidCallback toHome;
  VoidCallback toSignup;
  bool isWaiting;

  TextEditingController _emailInputCtrl;
  TextEditingController _pwdInputCtrl;

  bool _passwordVisible;

  @override
  void initState() {
    login = widget.login;
    toHome = widget.toHome;
    toSignup = widget.toSignup;
    isWaiting = widget.isWaiting;

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
                  autovalidate: false,
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
                      padding: EdgeInsets.all(15.0),
                      child: Text("LOG IN"),
                      onPressed: () async {
                        final form = _loginFormKey.currentState;
                        if (form.validate()) {
                          form.save();
                          await login(_emailInputCtrl.text.toString().trim(),
                              _pwdInputCtrl.text.toString().trim());

                          print("exited await login going toHome");
                          toHome();
                        }
                      },
                    ),
                  ])),
              SizedBox(
                height: 20,
              ),
              Text("Don't have an account?", textAlign: TextAlign.center),
              SizedBox(
                height: 5,
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: themeColors['lightBlue'])),
                  color: themeColors["lightBlue"],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  child: Text("SIGN UP"),
                  onPressed: () {
                    toSignup();
                  })
            ])));
  }
}

class LoginScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) =>
          LoginScreen(vm.login, vm.toHome, vm.toSignup, vm.isWaiting),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Future<void> Function(String, String) login;
  VoidCallback toHome;
  VoidCallback toSignup;
  bool isWaiting;

  ViewModel.build(
      {@required this.login,
      @required this.toHome,
      @required this.toSignup,
      @required this.isWaiting})
      : super(equals: [isWaiting]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        login: (String email, String password) =>
            dispatchFuture(LoginUserAction(email, password)),
        toHome: () {
          if (state.currentUser == null) {
            dispatch(NavigateAction.pushNamed("/"));
          }
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
        },
        toSignup: () => dispatch(NavigateAction.pushNamed("/signup")),
        isWaiting: state.waiting);
  }
}
