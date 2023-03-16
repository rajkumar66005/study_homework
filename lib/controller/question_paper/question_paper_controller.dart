import 'package:get/get.dart';
import 'package:study_homework/controller/auth_controller.dart';
import 'package:study_homework/firebase_references/reference.dart';
import 'package:study_homework/models/question_paper_model.dart';
import 'package:study_homework/screens/question/question_screen.dart';
import 'package:study_homework/services/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_homework/util/app_logger.dart';


class QuestionPaperController extends GetxController{

    final allPaperImages=<String>[].obs;
    final allPapers=<QuestionPaperModel>[].obs;

@override
void onReady()
{
  getAllpapers();
  super.onReady();
}
 Future<void> getAllpapers() async {
    List<String> imgname=['biology', 'chemistry','maths', 'physics' ];
    try{
      QuerySnapshot <Map<String,dynamic>> data=await questionPaperREF.get();
    final paperList= data.docs.map((paper) => QuestionPaperModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);

        for(var paper in paperList)
        {
         final imgUrl= await Get.find<FirebaseStorageService>().getImage(paper.title);
          paper.imageUrl=imgUrl;
        }
        allPapers.assignAll(paperList);
    }
      catch(e)
      {
        AppLogger.e(e);
      }
  } 

 void navigateToQuestions({ required QuestionPaperModel paper, bool tryAgain=false}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.back();
        Get.toNamed(QuestionsScreen.routeName, arguments: paper , preventDuplicates: false);
       }
       else{
        Get.toNamed(QuestionsScreen.routeName, arguments:paper);
       }
      }
   else{
   _authController.showLoginAlertDialogue();
  }
 }
}