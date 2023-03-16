import 'package:get/get.dart';
import 'package:study_homework/controller/auth_controller.dart';
import 'package:study_homework/controller/theme_controller.dart';
import 'package:study_homework/services/firebase_storage_service.dart';

class InitialBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(),permanent: true);
    Get.put(FirebaseStorageService());
  }

}