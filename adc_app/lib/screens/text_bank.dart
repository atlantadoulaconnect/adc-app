import 'package:adc_app/models/message.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TextBankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TextBankPageState();
}

class _TextBankPageState extends State<TextBankPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Text Bank")),
          actions: <Widget>[
            Container(
              width: 55,
              child: MaterialButton(),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
//                color: Colors.red,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 2.0
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text('"Category A"'),
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text("Question 1"),
                            Text("Answer A:"),
                            Text("Answer B:"),
                            Text("Question 2"),
                            Text("Answer A:"),
                            Text("Answer B:"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
          ],
        )
    );
  }
}