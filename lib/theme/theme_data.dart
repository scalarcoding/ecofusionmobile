import 'package:core_dashboard/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData customTheme(Brightness brightness) {
  var baseTheme = ThemeData(
      brightness: brightness, useMaterial3: false, fontFamily: "Montserrat");
  return baseTheme.copyWith(
      buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MainColor.brandColor)));
}
