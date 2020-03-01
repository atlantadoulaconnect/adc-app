import '../common.dart';
import '../../../backend/util/inputValidation.dart';

class SignupScreen extends StatefulWidget {
  final Future<void> Function(String, String) signUp;
  final VoidCallback toLogin;
  final VoidCallback toAppType;
  final bool isWaiting;

  SignupScreen(this.signUp, this.toLogin, this.toAppType, this.isWaiting);

  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  bool isWaiting;
  Future<void> Function(String, String) signUp;
  VoidCallback toAppType;
  VoidCallback toLogin;

  TextEditingController _emailCtrl;
  TextEditingController _passCtrl;
  TextEditingController _confirmPassCtrl;

  @override
  void initState() {
    isWaiting = widget.isWaiting;
    signUp = widget.signUp;
    toAppType = widget.toAppType;
    toLogin = widget.toLogin;
    _emailCtrl = TextEditingController();
    _passCtrl = TextEditingController();
    _confirmPassCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create an Account")),
        drawer: Menu(),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Text("Sign Up"),
            Form(
                key: _signupFormKey,
                autovalidate: false,
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email*",
                        hintText: "jane.doe@gmail.com",
                        icon: new Icon(Icons.mail,
                            color: themeColors["coolGray5"])),
                    controller: _emailCtrl,
                    validator: emailValidator,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password*",
                        hintText: "********",
                        icon: new Icon(Icons.lock,
                            color: themeColors["coolGray5"])),
                    controller: _passCtrl,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Confirm Password*",
                          hintText: "********",
                          icon: new Icon(Icons.lock,
                              color: themeColors["coolGray5"])),
                      controller: _confirmPassCtrl,
                      obscureText: true,
                      validator: (val) {
                        if (val != _passCtrl.text)
                          return "Passwords do not match.";
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          side: BorderSide(color: themeColors['yellow'])),
                      color: themeColors["yellow"],
                      textColor: Colors.black,
                      padding: EdgeInsets.all(15.0),
                      child: Text("SIGN UP"),
                      onPressed: () async {
                        final form = _signupFormKey.currentState;
                        if (form.validate()) {
                          form.save();

                          await signUp(_emailCtrl.text.toString().trim(),
                              _passCtrl.text.toString().trim());

                          // Nav push to appType
                          toAppType();
                        }
                      })
                ])),
            SizedBox(height: 20),
            Text("Already have an account?"),
            SizedBox(height: 5),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                onPressed: () {
                  toLogin();
                },
                color: themeColors["lightBlue"],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                child: Text("LOG IN")),
          ])),
        ));
  }
}

class SignupScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => SignupScreen(
        vm.signUp,
        vm.toLogin,
        vm.toAppType,
        vm.isWaiting,
      ),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Future<void> Function(String, String) signUp;
  VoidCallback toLogin;
  VoidCallback toAppType;
  bool isWaiting;

  ViewModel.build(
      {@required this.signUp,
      @required this.toLogin,
      @required this.toAppType,
      @required this.isWaiting})
      : super(equals: [isWaiting]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        signUp: (String email, String password) =>
            dispatchFuture(CreateUserAction(email, password)),
        toLogin: () => dispatch(NavigateAction.pushNamed("/login")),
        toAppType: () => dispatch(NavigateAction.pushNamed("/appType")),
        isWaiting: state.waiting);
  }
}
