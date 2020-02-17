import 'package:adc_app/theme/colors.dart';
import 'package:flutter/material.dart';

class RecentMessagesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RecentMessagesPageState();
}

class _RecentMessagesPageState extends State<RecentMessagesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recentContacts = ["Debbie D.", "Jane D.", "Sarah S."];
    final contactCards = <Widget>[];
    for (var i = 0; i < recentContacts.length; i++) {
      contactCards.add(Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
              )
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    width: 65,
                    height: 65,
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
                      size: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          recentContacts[i],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Doula",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Recent message will be ...",
                          style: TextStyle(
                              fontSize: 15,
                              color: themeColors["coolGray5"]
                          ),
                        ),
                      ]
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                            color: themeColors["black"]
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Recent Messages'),
          actions: <Widget>[
            Container(
              width: 60,
              child: MaterialButton(
                onPressed: () => Navigator.pushNamed(context, '/contacts'),
                child: Icon(
                  IconData(0xe150, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: contactCards,
            )
        )
    );
  }
}