import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_homework/firebase_references/loading_status.dart';
import 'package:study_homework/firebase_references/reference.dart';
import 'package:study_homework/models/question_paper_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataUploader extends GetxController{
  @override 
  void onReady(){
  uploadData();
  super.onReady();
  }

  final loadingStatus= LoadingStatus.loading.obs;// loadingStatus is observable 

Future<void> uploadData() async {
    loadingStatus.value=LoadingStatus.loading; //0

    final fireStore=FirebaseFirestore.instance;
  final manifestcontent= await DefaultAssetBundle.of(Get.context!).loadString("AssetManifest.json");
  final Map<String,dynamic> Manifestmap=  json.decode(manifestcontent);

  //load json files and print the path
 final papersInAssets= Manifestmap.keys.where((Path) => Path.startsWith("assets/DB/papers")&& Path.contains(".json")).toList();
        List<QuestionPaperModel> questionpaper =[];
        
      for(var paper in papersInAssets)
    {
   String papercontents = await rootBundle.loadString(paper);
   questionpaper.add(QuestionPaperModel.fromJson(jsonDecode(papercontents)));
    }
    //print(" items number ${questionpaper.length}");
     
     var batch=fireStore.batch();
     for(var paper in questionpaper)
     {
       batch.set(questionPaperREF.doc(paper.id),{
          "title":paper.title,
          "image_url":paper.imageUrl,
          "description":paper.description,
          "time_seconds":paper.timeSeconds,
          "questions_count":paper.questions==null?0:paper.questions!.length

       });
       for(var questions in paper.questions!)
       {
       final questionPath= questionRf(paperID: paper.id, questionID: questions.id);
        batch.set(questionPath,{
            "question":questions.question,
            "correct_answer":questions.correctAnswer

        } );

          for(var answer in questions.answers) 
          {
            batch.set(questionPath.collection("answers").doc(answer.identifier),{
              "identifier":answer.identifier,
              "answer":answer.answer

            });
          }
       }
     }
      
      await batch.commit();
      loadingStatus.value=LoadingStatus.completed;
}
}




