import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late SharedPreferences _prefs;

  SharedPreferenceProvider() {
    initSharedPreferences();
  }

  SharedPreferences get prefs => _prefs;

  void initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  set setSharedPreferences(SharedPreferences prefs) {
    _prefs = prefs;
    notifyListeners();
  }

  void updateSharedPreferences(List<Map<String, String>> value) {
    _prefs.setStringList("notesList", encodeJsonList(value));
    notifyListeners();
  }

  List<String> encodeJsonList(List<Map<String, String>> value) {
    List<String> encodedJsonList = value.map((e) => jsonEncode(e)).toList();
    return encodedJsonList;
  }

  List<Map<String, String>> getDecodedJsonList(List<String> value) {
    List<Map<String, String>> decodedJsonList =
        value.map((e) => jsonDecode(e) as Map<String, String>).toList();
    return decodedJsonList;
  }

  /// Makes `prefs` readable inside the devtools by showing its type and value
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // Add the prefs object as an object flag property to the diagnostic tree
    properties.add(ObjectFlagProperty('prefs', prefs));
  }
}
