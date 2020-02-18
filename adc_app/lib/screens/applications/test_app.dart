import 'package:flutter/material.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:adc_app/models/user.dart';
import 'package:adc_app/models/client.dart';
import 'package:adc_app/models/doula.dart';
import 'package:adc_app/util/auth.dart';

class TestAppPage extends StatefulWidget {
  User user;
  TestAppPage({Key key, @required this.user}) : super(key: key) {
    print("currentUser constructor test_app: \n${user.toString()}");
  }

  @override
  _TestAppPageState createState() => _TestAppPageState();
}

class _TestAppPageState extends State<TestAppPage> {
  TextEditingController _phoneInputController;
  User currentUser;

  @override
  void initState() {
    currentUser = widget.user;
    print("currentUser initState test_app_state: \n${currentUser.toString()}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Test Application")),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Spacer(),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Phone*",
                    hintText: "4045550000",
                    icon:
                        new Icon(Icons.phone, color: themeColors["coolGray5"])),
                controller: _phoneInputController,
                validator: phoneValidator,
                keyboardType: TextInputType.phone,
              ),
              Spacer(),
              FlatButton(
                color: themeColors["yellow"],
                textColor: Colors.black,
                padding: EdgeInsets.all(15.0),
                child: Text("COMPLETE"),
                onPressed: () {
                  print(
                      "userid: ${currentUser.userid} \nusertype: ${currentUser.userType}\nname: ${currentUser.name}\nemail: ${currentUser.email}");
                },
              )
            ])));
  }
}
