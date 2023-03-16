import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';
import 'package:get/get.dart';

TextStyle cartStyle(context)=>   TextStyle(
                      color: UIparameters.isDarkMode()?Theme.of(context).textTheme.bodyText1!.color:
                                                      Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold

                    );
const questionText = TextStyle(fontSize: 16, fontWeight:FontWeight.w800);
const detailText   = TextStyle(fontSize: 12); 
const headerText   = TextStyle(fontSize: 22, fontWeight:FontWeight.w700, color: onSurfaceTextColor ); 
const appBarText   = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: onSurfaceTextColor);

TextStyle countdowntimerTxt() => TextStyle(
  letterSpacing: 2,
  color: UIparameters.isDarkMode() ? Theme.of(Get.context!).textTheme.bodyText1!.color :
                                     Theme.of(Get.context!).primaryColor
);