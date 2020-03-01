import '../common.dart';

class TextBankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listOfCategories = [
      "Category A",
      "Category B",
      "Category C",
      "Category D",
      "Category E",
      "Category F"
    ];

    final listOfQuestions = [
      "Question 1:",
      "Question 2:",
      "Question 3:",
      "Question 4:",
      "Question 5:",
      "Question 6:"
    ];

    final listOfAnswers = [
      "Answers 1:",
      "Answers 2:",
      "Answers 3:",
      "Answers 4:",
      "Answers 5:",
      "Answers 6:"
    ];

    final QandATextFields = List<Widget>();

    for (var i = 0; i < listOfQuestions.length; i++) {
      QandATextFields.add(
        Text(
          listOfQuestions[i],
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
      QandATextFields.add(
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            listOfAnswers[i],
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    final categoryExpansionTiles = List<Widget>();

    for (var i = 0; i < listOfCategories.length; i++) {
      categoryExpansionTiles.add(ExpansionTile(
        title: Text(
          listOfCategories[i],
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: QandATextFields,
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Text Bank")),
          actions: <Widget>[
            Container(
              width: 55,
              child: MaterialButton(
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: ListView(
              children: categoryExpansionTiles,
            )));
  }
}

//class TextBankScreenConnector extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StoreConnector<AppState, ViewModel>();
//  }
//}
//
//class ViewModel extends BaseModel<AppState> {
//  ViewModel();
//
//  ViewModel.build();
//
//  @override
//  ViewModel fromStore() {}
//}
