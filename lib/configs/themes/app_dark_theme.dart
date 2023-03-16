import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:study_homework/configs/themes/sub_theme_data_mixin.dart';

const Color primaryDarkcolorDark=Color(0xFF2e3c62);
const Color primarycolorDark=Color(0xFF99ace1);
 const Color mainTextColorDark=Color.fromARGB(255, 255, 255, 255);


class DarkTheme with SubThemeData{
 ThemeData buildDarkTheme(){
   final ThemeData systemDarkTheme= ThemeData.dark();
   return systemDarkTheme.copyWith(iconTheme: getIconTheme(),
   textTheme: getTextTheme().apply(
      bodyColor: mainTextColorDark,
      displayColor: mainTextColorDark
   ));
  }
}