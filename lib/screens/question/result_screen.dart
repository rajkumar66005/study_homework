import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_homework/configs/themes/custom_text_style.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';
import 'package:study_homework/controller/question_paper/questions_controller.dart';
import 'package:study_homework/controller/question_paper/questions_controller_extension.dart';
import 'package:study_homework/screens/question/answer_check_screen.dart';
import 'package:study_homework/widgets/common/background_decoration.dart';
import 'package:study_homework/widgets/common/custom_app_bar.dart';
import 'package:study_homework/widgets/common/main_button.dart';
import 'package:study_homework/widgets/content_area.dart';
import 'package:study_homework/widgets/questions/answer_card.dart';
import 'package:study_homework/widgets/questions/question_number_card.dart';

class ResultScreen extends GetView<QuestionsController> {

  static const String routeName = "/resultscreen";

  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
              leading: const SizedBox(height: 80),
              title: controller.correctAnsweredQuestions,
            ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    SvgPicture.asset("assets/images/bulb.svg"),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 5),
                      child: Text(
                        'Congratulations',
                        style: headerText.copyWith(color: textColor),
                        
                      ),
                    ),
                    Text(
                      'You have ${controller.points} points',
                      style: TextStyle(
                            color: textColor),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Tap below numbers to view correct answers',
                      textAlign: TextAlign.center,
                       ),
                       SizedBox( height: 25),

                       Expanded(
                        child: GridView.builder(
                          itemCount: controller.allQuestions.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 75,
                            childAspectRatio: 1,
                            crossAxisSpacing: 9,
                            mainAxisSpacing: 8
                            ), 

                          itemBuilder: (_,index){
                           final _question = controller.allQuestions[index];
                           AnswerStatus _status = AnswerStatus.notanswered;
                           final _selectedanswer = _question.selectedAnswer;
                           final _correctanswer = _question.correctAnswer;

                           if(_selectedanswer == _correctanswer){
                                _status = AnswerStatus.correct;
                            }
                            else if(_question.selectedAnswer == null){
                              _status = AnswerStatus.wrong;
                            }
                            else{
                              _status = AnswerStatus.wrong;
                            }
                            return QuestionNumberCard(
                              index: index + 1, 
                              status: _status, 
                              onTap: (){
                                controller.jumpToQuestion(index, isGoback: false);
                                Get.toNamed(AnswerCheckScreen.routeName);
                              }
                              );
                          }
                          )
                        )

                  ],
                )
                )
              ),

              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIparameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          onTap: (){
                            controller.tryAgain();
                          },
                          color: Colors.blueGrey,
                          title: 'Try Again',
                          ),
                      ),
                      SizedBox(width: 6,),
                      Expanded(
                        child: MainButton(
                          onTap: (){
                            controller.saveTestResults();
                          },
                          title: 'Go Home',
                          ),
                      )
                    ],
                  ),
                  ),
                )
          ],
        ),
        )
    );
  }
}