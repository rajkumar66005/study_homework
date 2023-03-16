import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:study_homework/controller/auth_controller.dart';
import 'package:study_homework/controller/question_paper/questions_controller.dart';
import 'package:study_homework/firebase_references/reference.dart';

extension QuestionsControllerExtension on QuestionsController{

  int get correctQuestionCount => allQuestions.where((element) => element.selectedAnswer == element.correctAnswer).toList().length;

  String get correctAnsweredQuestions{
    return '$correctQuestionCount out of ${allQuestions.length}';
  }

  String get points{
    var points = (correctQuestionCount/allQuestions.length)* 100 *
     (questionPaperModel.timeSeconds - remainingSeconds)/questionPaperModel.timeSeconds * 100;

    return points.toStringAsFixed(2); 
  }

  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if(_user == null)
     return;

     batch.set(
      userRF.doc(_user.email).collection('my_recent_tests').doc(questionPaperModel.id),
      {
        "points": points,
        "correct_answer": '$correctQuestionCount/${allQuestions.length}',
        "questions_id"  :  questionPaperModel.id,
        "time" : questionPaperModel.timeSeconds - remainingSeconds,

      }
      );
      batch.commit();
      navigateToHomepage();
  }
}
