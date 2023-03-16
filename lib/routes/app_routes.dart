import 'package:study_homework/controller/question_paper/question_paper_controller.dart';
import 'package:study_homework/controller/question_paper/questions_controller.dart';
import 'package:study_homework/controller/zoom_drawer_controller.dart';
import 'package:study_homework/screens/home/home_screen.dart';
import 'package:study_homework/screens/introduction/introduction.dart';
import 'package:study_homework/screens/login/login_screen.dart';
import 'package:study_homework/screens/question/answer_check_screen.dart';
import 'package:study_homework/screens/question/question_screen.dart';
import 'package:study_homework/screens/question/result_screen.dart';
import 'package:study_homework/screens/question/test_overview_screen.dart';
import 'package:study_homework/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
          name: "/introduction",
          page: () =>  const AppIntroductionScreen(),
        ),
        GetPage(
            name: "/home",
            page: () =>  const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
         GetPage(
          name: AppLoginScreen.routeName,
           page:()=>const AppLoginScreen()
           ),
           GetPage(
          name: QuestionsScreen.routeName,
           page:()=>const QuestionsScreen(),
           binding: BindingsBuilder((){
            Get.put<QuestionsController>(QuestionsController());
           })
           ),
           GetPage(
            name: TestOverviewscreen.routeName,
             page: ()=> const TestOverviewscreen()
             ),
            GetPage(
              name: ResultScreen.routeName, 
              page: ()=> const ResultScreen()
              ),
              GetPage(
              name: AnswerCheckScreen.routeName, 
              page: ()=> const AnswerCheckScreen()
              )
      ];
}
