import 'package:flutter/material.dart';
import 'package:pujapurohit/colors/light_colors.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    buttonColor: LightColors.prime,
    primaryColor: LightColors.prime,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    buttonColor: Colors.red,
  );
}