import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;

  Future initPref() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
    return _prefs;
  }

  // /// Makes `notesList` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IterableProperty('SharedPreference', prefs));
  // }
}