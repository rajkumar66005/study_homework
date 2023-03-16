import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_homework/firebase_references/reference.dart';
import 'package:study_homework/screens/home/home_screen.dart';
import 'package:study_homework/screens/login/login_screen.dart';
import 'package:study_homework/util/app_logger.dart';
import 'package:study_homework/widgets/dialogs/dialogue_widget.dart';
class AuthController extends GetxController{
@override 
void onReady() {
  initAuth();
  super.onReady();
}

late FirebaseAuth _auth;

final _user=Rxn<User>();
late Stream<User?> _authstatechange;

void initAuth() async{
  await Future.delayed(const Duration(seconds: 2));
  _auth=FirebaseAuth.instance;
  _authstatechange=_auth.authStateChanges();
  _authstatechange.listen((User? user) { 
      _user.value=user;

  });
  NavigatetoIntroduction();
}

Future<void> signInWithGoogle() async {
  final GoogleSignIn _googlesignin = GoogleSignIn();
  try{
   GoogleSignInAccount? account= await _googlesignin.signIn();
   if(account!=null){
     final _authaccount= await account.authentication;
     final _credentials= GoogleAuthProvider.credential(
        idToken: _authaccount.idToken,
        accessToken: _authaccount.accessToken
     );
      await _auth.signInWithCredential(_credentials);
      await saveUser(account);
      navigateToHomePage();
   }
  }on Exception catch(error){
    AppLogger.e(error);
  }
}

User? getUser(){
  _user.value=_auth.currentUser;
  return _user.value;
}

saveUser(GoogleSignInAccount account){
   userRF.doc(account.email).set({
      "email":account.email,
      "name":account.displayName,
      "profilepic":account.photoUrl
   });
}

Future<void> signOut() async {
  AppLogger.d('sign out');
  try{
     await _auth.signOut();
     navigateToHomePage();
  }on FirebaseAuthException catch(e){
    AppLogger.e(e);
  }
}

void NavigatetoIntroduction()
{
  Get.offAllNamed("/introduction");
}

void navigateToHomePage(){
  Get.offAllNamed(HomeScreen.routeName);
}

void showLoginAlertDialogue(){
      Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      navigateToLoginPage();

      }),
      barrierDismissible: false
      );
}

void navigateToLoginPage(){
  Get.toNamed(AppLoginScreen.routeName);
}

bool isLoggedIn(){
  return _auth.currentUser != null;
}
}