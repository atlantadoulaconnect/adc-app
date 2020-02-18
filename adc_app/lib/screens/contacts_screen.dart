import 'package:adc_app/theme/colors.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recentContacts = ["Debbie D.", "Jane D.", "Sarah S."];
    final contactCards = <Widget>[];
    for (var i = 0; i < recentContacts.length; i++) {
      contactCards.add(
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2.0,
                ),
              borderRadius: BorderRadius.all(
                const Radius.circular(20.0)
              ),
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
                      padding: EdgeInsets.only(left: 12, right: 20.0),
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
                          ]
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        IconData(57545, fontFamily: 'MaterialIcons'),
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ]),
            ) 
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: contactCards,
            )
        )
    );
  }
}