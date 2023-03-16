import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/controller/auth_controller.dart';
import 'package:study_homework/widgets/common/main_button.dart';

class AppLoginScreen extends GetView<AuthController> {
  const AppLoginScreen({super.key});

static const String routeName="/loginscreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
           Image.asset("assets/images/app_splash_logo.png" , width: 200, height: 200),
           const Padding(
             padding: EdgeInsets.symmetric(vertical: 60),
             child: Text("Study app, learn your subjects, Try the quiz, practice till you feel comfortable",
             style: TextStyle(
              color: onSurfaceTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold
             ),
             textAlign: TextAlign.center,
             ),
           ),
            MainButton(
              onTap: (){
                    controller.signInWithGoogle();
              },
              child:Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: SvgPicture.asset("assets/icons/google.svg")
                    ),
                   Center(
                     child: Text("Sign in with Google",
                     style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold
                  ),
                  ),
                   ),
                ],
              ) ,
            ),
            
          ]
        ),
      ),
    );
  }
}