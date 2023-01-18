
import 'package:flutter/material.dart';

class PlayListEditorProvider extends ChangeNotifier {
  var isEditor = false;

  void change(bool value) {
    isEditor = value;
    notifyListeners();
  }
}
