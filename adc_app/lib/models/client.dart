import 'package:adc_app/models/contact.dart';
import 'package:adc_app/models/user.dart';

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

  Client(String userid, String userType, String name, String email)
      : super(userid, userType, name, email) {
    this.deliveryTypes = new List();
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
}
