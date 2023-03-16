import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_homework/configs/themes/app_dark_theme.dart';
import 'package:study_homework/configs/themes/app_light_theme.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFF3ac3cb);
const Color wrongAnswerColor   = Color(0xFFF85187);
const Color notAnsweredColor   = Color(0xFF2a3c65);

const mainGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
            primaryLightColorLight,
            primaryColorLight
  ]
);

const mainGradientDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
            primaryDarkcolorDark,
            primarycolorDark
  ]
);

LinearGradient mainGradient() =>
 UIparameters.isDarkMode()?mainGradientDark:mainGradientLight; 

Color customScaffold(BuildContext context)=> 
                                UIparameters.isDarkMode()?Color(0xFf2e3c62):
                                Color.fromARGB(255, 240, 237, 255);

Color answerSelectedcolor()=> UIparameters.isDarkMode()? Theme.of(Get.context!).cardColor.withOpacity(0.5):
                                  Theme.of(Get.context!).primaryColor;

Color answerBordercolor()=> UIparameters.isDarkMode()? Color.fromARGB(255, 20, 46, 159) : 
                                  Color.fromARGB(255, 221, 221, 221);