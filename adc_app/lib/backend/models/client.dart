import './contact.dart';
import './user.dart';

class Client extends User {
  String phone;
  String bday;

  User primaryDoula;
  User backupDoula;

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

  String applicantEmail() {
    return "APPLICANT:\n\t${this.name}\n\t${this.email}\n\t${this.phone}\n\tBirth date: ${this.bday}\nPREGNANCY:\n\tDue date: ${this.dueDate}\n\tBirth location: ${this.birthLocation}";
  }
}
