import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/configs/themes/custom_text_style.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';
import 'package:study_homework/controller/question_paper/questions_controller.dart';
import 'package:study_homework/screens/home/question_card.dart';
import 'package:study_homework/widgets/common/background_decoration.dart';
import 'package:study_homework/widgets/common/custom_app_bar.dart';
import 'package:study_homework/widgets/common/main_button.dart';
import 'package:study_homework/widgets/content_area.dart';
import 'package:study_homework/widgets/questions/answer_card.dart';
import 'package:study_homework/widgets/questions/countdown_timer.dart';
import 'package:study_homework/widgets/questions/question_number_card.dart';

class TestOverviewscreen extends GetView<QuestionsController> {
  static const String routeName ='/testoverview';

  const TestOverviewscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
        child:Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountdownTimer(
                          color: UIparameters.isDarkMode()? Theme.of(context).textTheme.bodyText1!.color :
                                                            Theme.of(context).primaryColor,
                          time: '',
                        ),
                        Obx(
                          ()=> Text(
                            '${controller.time} Remaining',
                            style: countdowntimerTxt(),
                          )
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75 ,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8
                        ),
                        itemBuilder: (_ , index){
                          AnswerStatus? _answerstatus;
                          if(controller.allQuestions[index].selectedAnswer != null){
                            _answerstatus = AnswerStatus.answered;
                          }
                          return QuestionNumberCard(
                            index: index + 1, 
                            status: _answerstatus, 
                            onTap: ()=> controller.jumpToQuestion(index)
                            );
                        }
                    
                        ),
                    ),
                    ColoredBox(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: UIparameters.mobileScreenPadding,
                        child: MainButton(
                          onTap: (){
                              controller.complete();
                          },
                          title: 'Complete',
                          ),
                        ),
                        
                    )
                  ],
                )
                )
              )
          ],
        )
        ),
    );
  }
}