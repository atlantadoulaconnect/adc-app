import './contact.dart';
import './user.dart';
import './doula.dart';

class Client extends User {
  String phone;
  String bday;

  Doula primaryDoula;
  Doula backupDoula;

  String dueDate;
  String birthLocation;
  String birthType;
  bool epidural;
  bool cesarean;
  List<Contact> emergencyContacts = new List<Contact>();

  int liveBirths;
  bool preterm;
  bool lowWeight;
  List<String> deliveryTypes;
  bool multiples;

  bool meetBefore;
  bool homeVisit;

  bool photoRelease;

  Client(String userid, String userType, String email)
      : super(userid, userType, email) {
    this.deliveryTypes = new List<String>();
    this.emergencyContacts = new List<Contact>();
  }

  void addDeliveryType(String deliveryType) {
    this.deliveryTypes.add(deliveryType);
  }

  void removeDeliveryType(String deliveryType) {
    this.deliveryTypes.remove(deliveryType);
  }

  void addContact(Contact contact) {
    this.emergencyContacts.add(contact);
  }

  void removeContact(Contact contact) {
    this.emergencyContacts.remove(contact);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Client &&
          runtimeType == other.runtimeType &&
          phone == other.phone &&
          bday == other.bday &&
          primaryDoula == other.primaryDoula &&
          backupDoula == other.backupDoula &&
          dueDate == other.dueDate &&
          birthLocation == other.birthLocation &&
          birthType == other.birthType &&
          epidural == other.epidural &&
          cesarean == other.cesarean &&
          emergencyContacts == other.emergencyContacts &&
          liveBirths == other.liveBirths &&
          preterm == other.preterm &&
          lowWeight == other.lowWeight &&
          deliveryTypes == other.deliveryTypes &&
          multiples == other.multiples &&
          meetBefore == other.meetBefore &&
          homeVisit == other.homeVisit &&
          photoRelease == other.photoRelease;

  @override
  int get hashCode =>
      super.hashCode ^
      phone.hashCode ^
      bday.hashCode ^
      primaryDoula.hashCode ^
      backupDoula.hashCode ^
      dueDate.hashCode ^
      birthLocation.hashCode ^
      birthType.hashCode ^
      epidural.hashCode ^
      cesarean.hashCode ^
      emergencyContacts.hashCode ^
      liveBirths.hashCode ^
      preterm.hashCode ^
      lowWeight.hashCode ^
      deliveryTypes.hashCode ^
      multiples.hashCode ^
      meetBefore.hashCode ^
      homeVisit.hashCode ^
      photoRelease.hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
