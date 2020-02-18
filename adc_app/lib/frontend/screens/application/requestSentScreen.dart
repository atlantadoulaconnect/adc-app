import '../common.dart';

class RequestSentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Application Sent")),
        drawer: Menu(),
        body: Center(
            //child: Text("Your application has been sent.")
            child: Text(
          'Your application has been sent.',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: themeColors['emoryBlue'],
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        )));
  }
}
