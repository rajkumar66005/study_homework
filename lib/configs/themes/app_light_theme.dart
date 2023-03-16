import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:study_homework/configs/themes/sub_theme_data_mixin.dart';

const Color primaryLightColorLight =Color(0xFF3ac3cb);
const Color primaryColorLight =Color(0xFFf85187);
const Color mainTextcolorLight=Color.fromARGB(255, 0, 0, 0);
const Color cardColor =Color.fromARGB(255, 254, 254, 255);


class LightTheme with SubThemeData{
  buildLightTheme(){
   final ThemeData systemLightTheme= ThemeData.light();
   return systemLightTheme.copyWith(
        primaryColor: primaryColorLight,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: getIconTheme(),
        cardColor: cardColor,
        textTheme: getTextTheme().apply( 
        bodyColor: mainTextcolorLight,
        displayColor: mainTextcolorLight
   )
   );
  }
}