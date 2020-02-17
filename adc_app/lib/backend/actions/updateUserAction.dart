import 'package:async_redux/async_redux.dart';

import '../models/client.dart';
import '../models/doula.dart';
import '../models/emergencyContact.dart';
import '../models/phone.dart';
import '../states/appState.dart';

class UpdateClientUserAction extends ReduxAction<AppState> {
  final Client current;

  final String userid;
  final String userType;
  final String name;
  final List<Phone> phones;
  final String email;
  final bool phoneVerified;

  final String bday;
  final Doula primaryDoula;
  final Doula backupDoula;
  final String dueDate;
  final String birthLocation;
  final String birthType;
  final bool epidural;
  final bool cesarean;
  final List<EmergencyContact> emergencyContacts;

  final int liveBirths;
  final bool preterm;
  final bool lowWeight;
  final List<String> deliveryTypes;
  final bool multiples;

  final bool meetBefore;
  final bool homeVisit;
  final bool photoRelease;

  UpdateClientUserAction(this.current,
      {this.userid,
      this.userType,
      this.name,
      this.phones,
      this.email,
      this.phoneVerified,
      this.bday,
      this.primaryDoula,
      this.backupDoula,
      this.dueDate,
      this.birthLocation,
      this.birthType,
      this.epidural,
      this.cesarean,
      this.emergencyContacts,
      this.liveBirths,
      this.preterm,
      this.lowWeight,
      this.deliveryTypes,
      this.multiples,
      this.meetBefore,
      this.homeVisit,
      this.photoRelease});

  @override
  AppState reduce() {
    Client updated = current.copy(
        userid: this.userid,
        userType: this.userType,
        name: this.name,
        phones: this.phones,
        email: this.email,
        phoneVerified: this.phoneVerified,
        bday: this.bday,
        primaryDoula: this.primaryDoula,
        backupDoula: this.backupDoula,
        dueDate: this.dueDate,
        birthLocation: this.birthLocation,
        birthType: this.birthType,
        epidural: this.epidural,
        cesarean: this.cesarean,
        emergencyContacts: this.emergencyContacts,
        liveBirths: this.liveBirths,
        preterm: this.preterm,
        lowWeight: this.lowWeight,
        deliveryTypes: this.deliveryTypes,
        multiples: this.multiples,
        meetBefore: this.meetBefore,
        homeVisit: this.homeVisit,
        photoRelease: this.photoRelease);

    return state.copy(currentUser: updated);
  }
}

class UpdateDoulaUserAction extends ReduxAction<AppState> {
  final Doula current;

  final String userid;
  final String userType;

  final String name;
  final String email;

  final List<Phone> phones;

  final bool phoneVerified;

  final String bday;
  final bool emailVerified;

  final String bio;
  final bool certified;
  final bool certInProgress;
  final String certProgram;
  final int birthsNeeded;
  final List<String> availableDates;

  final List<Client> currentClients;

  UpdateDoulaUserAction(this.current,
      {this.userid,
      this.userType,
      this.name,
      this.email,
      this.phones,
      this.phoneVerified,
      this.bday,
      this.emailVerified,
      this.bio,
      this.certified,
      this.certInProgress,
      this.certProgram,
      this.birthsNeeded,
      this.availableDates,
      this.currentClients});

  @override
  AppState reduce() {
    Doula updated = current.copy(
        userid: userid ?? this.userid,
        userType: userType ?? this.userType,
        name: name ?? this.name,
        email: email ?? this.email,
        phones: phones ?? this.phones,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        bday: bday ?? this.bday,
        emailVerified: emailVerified ?? this.emailVerified,
        bio: bio ?? this.bio,
        certified: certified ?? this.certified,
        certInProgress: certInProgress ?? this.certInProgress,
        certProgram: certProgram ?? this.certProgram,
        birthsNeeded: birthsNeeded ?? this.birthsNeeded,
        availableDates: availableDates ?? this.availableDates,
        currentClients: currentClients ?? this.currentClients);

    return state.copy(currentUser: updated);
  }
}
