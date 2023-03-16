import 'package:study_homework/models/question_paper_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore =FirebaseFirestore.instance;
final userRF= fireStore.collection("users");

final questionPaperREF = fireStore.collection('questionPapers');
DocumentReference questionRf({
          required String paperID,
          required String questionID,
            }
            )=> questionPaperREF.doc(paperID).collection("questions").doc(questionID);

            Reference get firebaseStorage => FirebaseStorage.instance.ref();