import 'package:get/get.dart';
import 'package:study_homework/firebase_references/reference.dart';




class FirebaseStorageService extends GetxService{
 Future<String?> getImage(String? imgname) async{
    if(imgname==null){
      return null;
    }
    try{
       var urlRef= firebaseStorage.child("question_paper_images").child('${imgname.toLowerCase()}.png');
       var imgUrl=await urlRef.getDownloadURL();
       return imgUrl;
    }
    catch(e){
        return null;
    }
  }

}