
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_homework/binding/initial_binding.dart';
import 'package:study_homework/configs/themes/app_light_theme.dart';
import 'package:study_homework/controller/theme_controller.dart';
import 'package:study_homework/data_uploader_screen.dart';
import 'package:study_homework/firebase_options.dart';
import 'package:get/get.dart';
import 'package:study_homework/routes/app_routes.dart';
import 'package:study_homework/screens/introduction/introduction.dart';
import 'package:study_homework/screens/splash/splash_screen.dart';

import 'configs/themes/app_dark_theme.dart';

/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( GetMaterialApp(home:DataUploaderScreen()));
}
*/

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().darkTheme,
      getPages:AppRoutes.routes()
    );
  }
}