import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study_homework/controller/auth_controller.dart';
import 'package:study_homework/controller/question_paper/question_paper_controller.dart';
import 'package:study_homework/firebase_references/loading_status.dart';
import 'package:study_homework/firebase_references/reference.dart';
import 'package:study_homework/models/question_paper_model.dart';
import 'package:study_homework/screens/home/home_screen.dart';
import 'package:study_homework/screens/question/result_screen.dart';

class QuestionsController extends GetxController{
  final loadingStatus= LoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final allQuestions=<Questions>[];
  final questionsIndex=0.obs;
  bool get isFirstQuestion => questionsIndex.value > 0 ;
  bool get isLastQuestion => questionsIndex.value >= allQuestions.length-1;

  Rxn<Questions> currentQuestion= Rxn<Questions>();

  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00.00'.obs;


  @override
  void onReady()
  {
    final _questionPaper=Get.arguments as QuestionPaperModel;
    print(_questionPaper.title);
    loadData(_questionPaper);
    super.onReady();
  }

Future<void> loadData(QuestionPaperModel questionPaper)async {
      questionPaperModel=questionPaper; 
      loadingStatus.value=LoadingStatus.loading;

      try{
         final QuerySnapshot<Map<String,dynamic>> questionQuery =
          await questionPaperREF.doc(questionPaper.id)
                                .collection("questions")
                                .get();

        final questions = questionQuery.docs.map((snapshot) => Questions.fromSnapshot(snapshot)).toList();
         questionPaper.questions=questions;

         for(Questions _question in questionPaper.questions!){
          final QuerySnapshot<Map<String,dynamic>> answersQuery =
                await questionPaperREF.doc(questionPaper.id)
                                  .collection("questions")
                                  .doc(_question.id)
                                  .collection("answers")
                                  .get();
          final answers= answersQuery.docs.map((answer) => Answers.fromSnapshot(answer)).toList();
          _question.answers=answers;
         } 

      } catch(e){
        if (kDebugMode) {
          print(e.toString());
    }
  }
  if(questionPaper.questions != null && questionPaper.questions!.isNotEmpty){
          allQuestions.assignAll(questionPaper.questions!);
          currentQuestion.value=questionPaper.questions![0];
          _startTimer(questionPaper.timeSeconds);
          
            print(questionPaper.questions![0].question);
          
          loadingStatus.value=LoadingStatus.completed;
          }
          else{
            loadingStatus.value=LoadingStatus.error;
          }
}

void selectedAnswer(String? answer){
  currentQuestion.value!.selectedAnswer= answer;
  update(['answers_list','answer_review_list']);
}

String get completedTest{
 final answered = allQuestions.where((element) => element.selectedAnswer!=null).toList().length;
  return '$answered out of ${allQuestions.length}';
}

void jumpToQuestion(int index, {bool isGoback=true}){
  questionsIndex.value  = index;
  currentQuestion.value = allQuestions[index];
  if(isGoback){
    Get.back();
  }
}

void nextQuestion(){
  if(questionsIndex.value >= allQuestions.length-1)
  return;
  questionsIndex.value++;
  currentQuestion.value = allQuestions[questionsIndex.value];
  
}

void previousQuestion(){
 if(questionsIndex.value <= 0)
  return ;
  questionsIndex.value--;
  currentQuestion.value = allQuestions[questionsIndex.value];
}

_startTimer(int seconds){
  const duration = Duration(seconds: 1);
  remainingSeconds=seconds;
 _timer = Timer.periodic(duration, (Timer timer) {
    if(remainingSeconds==0){
      timer.cancel();
    }else{
      int minutes = remainingSeconds ~/ 60 ;
      int seconds = remainingSeconds % 60 ;
      time.value  = minutes.toString().padLeft(2,"0")+":"+seconds.toString().padLeft(2,"0");
      remainingSeconds--; 

    }
   }
  );
}

  void complete(){
      _timer!.cancel();
      Get.offAndToNamed(ResultScreen.routeName);
    }

  void tryAgain(){
    Get.find<QuestionPaperController>().navigateToQuestions(
              paper: questionPaperModel,
              tryAgain: true
              );
  }

  void navigateToHomepage(){
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName , (route) => false);
  }
  
}