import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:study_homework/controller/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController{
  final zoomDrawerController= ZoomDrawerController();
  Rxn<User?> user= Rxn();


  @override
  void onReady(){ 
    user.value=Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer(){
    zoomDrawerController.toggle?.call();
    update();    
  }

  void signIn(){

  }

  void signOut(){
      Get.find<AuthController>().signOut();

  }
  void website(){
      _launch("https://google.com");
  }

   void facebook(){
      _launch("https://facebook.com");
  }

  void email(){
    final Uri emailLaunch =Uri(
      scheme: 'mailto',
      path: '66005raj@gmail.com'
    );
    _launch(emailLaunch.toString());
  }

 Future<void> _launch(String url)async{
      if(!await launch(url)){
        throw 'could not launch $url';
      }
  }
}
