import 'package:flutter/foundation.dart';

class ColorSizesNotifier with ChangeNotifier {
  String _sizes = '';

  String get sizes => _sizes;

  void setSizes(String s) {
    if (sizes == s) {
      _sizes = '';
    } else {
      _sizes = s;
    }
    notifyListeners();
  }

  String _color = '';

  String get color => _color;

  void setColor(String c) {
    if (color == c) {
      _color = '';
    } else {
      _color = c;
    }
    notifyListeners();
  }
}
