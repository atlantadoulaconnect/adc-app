import 'package:adc_app/models/user.dart';
import 'package:adc_app/models/client.dart';

class Doula extends User {
  String bday;
  String bio;
  String phone;
  bool certified;
  bool certInProgress;
  String certProgram;
  int birthsNeeded;
  List<String> availableDates;

  List<Client> currentClients;

  Doula(String userid, String userType, String email)
      : super(userid, userType, email) {
    this.availableDates = new List<String>();
    this.currentClients = new List<Client>();
  }

  //for confirmation page
  String getYesOrNoFromBool(bool yesOrNo) {
    if (yesOrNo == true) {
      return "Yes";
    } else {
      return "No";
    }
  }

  void addAvailableDate(String date) {
    this.availableDates.add(date);
  }

  void removeAvailableDate(String date) {
    this.availableDates.remove(date);
  }

  void addCurrentClient(Client client) {
    this.currentClients.add(client);
  }

  void removeCurrentClient(Client client) {
    this.currentClients.remove(client);
  }
}
