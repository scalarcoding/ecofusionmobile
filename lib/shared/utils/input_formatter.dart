import 'package:flutter/services.dart';

class InputFormatter {
  static TextInputFormatter numberOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  static TextInputFormatter textOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[a-z]'));
}
