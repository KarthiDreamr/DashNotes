import 'package:flutter/foundation.dart';

class NotesListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List _notesList = [  ];

  List get notesList => _notesList;

  void addNotes(Map<String, String> value) {
    _notesList.add(value);
    notifyListeners();
  }

  void removeNotes(int index) {
    _notesList.removeAt(index);
    notifyListeners();
  }

  set setNotesList(List listList) {
    _notesList = listList;
    notifyListeners();
  }

  void updateNotes(int index, String type, String value) {
    _notesList[index][type] = value;
    notifyListeners();
  }

  /// Makes `notesList` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('notesList', notesList));
  }
}
