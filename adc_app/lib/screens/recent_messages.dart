import 'package:adc_app/screens/home_screen.dart';
import 'package:adc_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class RecentMessagesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RecentMessagesPageState();
}

class _RecentMessagesPageState extends State<RecentMessagesPage> {
  @override
  void initState() {
    super.initState();
  }

  final MenuMaker _myMenuMaker = MenuMaker();

  @override
  Widget build(BuildContext context) {
    final recentContacts = ["Debbie D.", "Jane D.", "Sarah S."];
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
                )
            ),
            child: MaterialButton(
              onPressed: () => Navigator.pushNamed(context, '/messages'),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                                color: themeColors["black"]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )
          ),
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
            onPressed: () => launch("tel:$number"),
            color: themeColors["yellow"],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(color: themeColors['yellow'])
            ),
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
                onPressed: () => Navigator.pushNamed(context, '/contacts'),
                child: Icon(
                  IconData(0xe150, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        drawer: _myMenuMaker.createMenu(context),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: contactCards,
            )
        )
    );
  }
}