import 'dart:convert';

import 'package:adc_app/backend/states/appState.dart';
import 'package:async_redux/async_redux.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/admin.dart';
import '../models/client.dart';
import '../models/doula.dart';
import '../models/user.dart';

// Singleton class that handles persisting to/loading from local disk

class Persistence implements Persistor<AppState> {
  Duration _throttle;
  Duration _saveDuration;
  // location in phone to save data
  //String _localDir;
  //File _userFile;

  Persistence({Duration throttle, Duration saveDuration}) {
    _throttle = throttle;
    _saveDuration = saveDuration;
  }

  Duration get throttle => _throttle;
  Duration get saveDuration => _saveDuration;

  Future<String> loadDirectory() async {
    Directory dir = await getApplicationDocumentsDirectory();

    return dir.path;
  }

  // returns null if the file for that user wasn't previously saved
  Future<File> loadUserFile(String userid) async {
    print("load user file called");
    String localDir = await loadDirectory();
    File saved = File("$localDir/$userid.json");
    return saved.exists().then((bool exists) {
      if (exists) return saved;
      return null;
    });
  }

  Future<File> loadAppFile() async {
    print("load app file called");
    String localDir = await loadDirectory();
    File saved = File("$localDir/initializer.json");
    return saved.exists().then((bool exists) {
      if (exists) return saved;
      return null;
    });
  }

  // param state determined by the files saved in the local directory
  @override
  Future<void> saveInitialState(AppState state) {
    return persistDifference(lastPersistedState: null, newState: state);
  }

  // return null if no past user or user is not logged in
  Future<AppState> readInitialState() {
    return loadAppFile().then((File initJSON) {
      if (initJSON != null) {
        Map<String, dynamic> initializer =
            jsonDecode(initJSON.readAsStringSync());

        String jsonUserId = initializer["lastUser"].toString();
        print("last user id: $jsonUserId");

        if (jsonUserId != null && jsonUserId.length > 4) {
          if (initializer["loggedIn"] == true) {
            return loadUserFile(jsonUserId).then((File currUserFile) {
              return currUserFile.exists().then((bool exists) {
                if (exists) {
                  return AppState.fromJson(
                      jsonDecode(currUserFile.readAsStringSync()));
                }
                return AppState(currentUser: null, waiting: false, peer: null);
              });
            });
          }
        }
      }

      return AppState(currentUser: null, waiting: false, peer: null);
    });
  }

  //Future<void> updateInitializer({String userid, bool loggedIn}) {}

  @override
  Future<AppState> readState() {
    // TODO: implement readState
    // check initializer for logged in user, return that user's state or null state
    print("read state called");
    return null;
  }

  @override
  Future<void> persistDifference(
      {AppState lastPersistedState, AppState newState}) async {
    String localDir = await loadDirectory();
    // if currentUser with valid id. Write to file
    if (newState.currentUser != null &&
        newState.currentUser.userid.length > 4) {
      File userFile = File("$localDir/${newState.currentUser.userid}.json");
      userFile.writeAsStringSync(jsonEncode(newState.toJson()));
    }
  }

  @override
  Future<void> deleteState() {
    // TODO: implement deleteState
    // use: "Forget me on this device" option?
    print("delete state called");
  }

  // TODO: methods to read from json file and write to json file
  // Map<String, dynamic> readFile (String filePath)
  // void writeFile (Map<String, dynamic> json)

}
