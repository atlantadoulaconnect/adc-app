import './user.dart';
import './client.dart';

class Doula extends User {
  String bday;
  bool emailVerified;

  String bio;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Doula &&
          runtimeType == other.runtimeType &&
          bday == other.bday &&
          emailVerified == other.emailVerified &&
          bio == other.bio &&
          certified == other.certified &&
          certInProgress == other.certInProgress &&
          certProgram == other.certProgram &&
          birthsNeeded == other.birthsNeeded &&
          availableDates == other.availableDates &&
          currentClients == other.currentClients;

  @override
  int get hashCode =>
      super.hashCode ^
      bday.hashCode ^
      emailVerified.hashCode ^
      bio.hashCode ^
      certified.hashCode ^
      certInProgress.hashCode ^
      certProgram.hashCode ^
      birthsNeeded.hashCode ^
      availableDates.hashCode ^
      currentClients.hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
