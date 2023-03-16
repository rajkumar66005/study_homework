import 'package:flutter/material.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:Get.width*0.2 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star,size: 60),
                SizedBox(height: 40),
                const Text( 
                  " Study app learn and gain knowledge through tests and other events particulary because this application is made by top professionals, who only want others to thrive with sucess",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                    fontSize: 18,
                    color: onSurfaceTextColor,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                 SizedBox(height: 40),
                 AppCircleButton(
                      onTap: () => Get.offAndToNamed("/home"),
                      child: const Icon(Icons.arrow_forward, size: 35)      
                 )
              ],
            ),
          ),
      ),
    );
  }
}