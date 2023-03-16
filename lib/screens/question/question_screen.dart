import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/configs/themes/custom_text_style.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';
import 'package:study_homework/controller/question_paper/questions_controller.dart';
import 'package:study_homework/firebase_references/loading_status.dart';
import 'package:study_homework/screens/question/test_overview_screen.dart';
import 'package:study_homework/widgets/common/background_decoration.dart';
import 'package:study_homework/widgets/common/custom_app_bar.dart';
import 'package:study_homework/widgets/common/main_button.dart';
import 'package:study_homework/widgets/common/question_place_holder.dart';
import 'package:study_homework/widgets/content_area.dart';
import 'package:study_homework/widgets/questions/answer_card.dart';
import 'package:study_homework/widgets/questions/countdown_timer.dart';

class QuestionsScreen extends GetView<QuestionsController> {
   
  static const String routeName= '/questionscreen';  
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 8 , vertical: 4),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide( color: onSurfaceTextColor , width : 2 )
            )
            ),
          child: Obx(
            ()=> CountdownTimer(
              time: controller.time.value,
              color: onSurfaceTextColor,
              )
          ) 
        ),
        showActionIcon: true,

        titlewidget:Obx(
          ()=> Text( 
            'Q. ${(controller.questionsIndex.value+1).toString().padLeft(2,'0')}' ,
            style: appBarText,
             )
        )
       
      ),
      body: BackgroundDecoration(
        child:Obx(
            ()=>Column(
              children:[ 
                if(controller.loadingStatus.value == LoadingStatus.loading)
                 const Expanded(
                  child: ContentArea(child: QuestionscreenHolder())
                  ),

                if(controller.loadingStatus.value == LoadingStatus.completed)
                Expanded(
                  child: ContentArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 35),

                    child: Column(
                      children: [
                    Text(
                     controller.currentQuestion.value!.question,
                     style: questionText,
                    ),

                    GetBuilder<QuestionsController>(id: 'answers_list',builder: (context){

                      return ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 25),
                        physics: NeverScrollableScrollPhysics(),

                        itemBuilder : (BuildContext context , int index){
                              final answer = controller.currentQuestion.value!.answers[index];
                              return AnswerCard(
                                  answer: '${answer.identifier} . ${answer.answer}',
                                   onTap: (){
                                controller.selectedAnswer(answer.identifier);
                                            },
                             isSelected: answer.identifier == controller.currentQuestion.value!.selectedAnswer,   
                          );
                        },
                        separatorBuilder: (BuildContext context , int index) => const SizedBox(height: 10,),
                        itemCount       : controller.currentQuestion.value!.answers.length
                        );
                        }
                        )
                       ],
                     ),
                    ),
                  ),
                ),
                ColoredBox(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: UIparameters.mobileScreenPadding,
                        child: Row(
                            children: [
                                Visibility(
                                  visible: controller.isFirstQuestion,
                                  child: SizedBox(
                                    width: 55,
                                    height: 55,
                                    child: MainButton(
                                      onTap: (){
                                        controller.previousQuestion();
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Get.isDarkMode?onSurfaceTextColor : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Visibility(
                                  
                                  visible: controller.loadingStatus.value == LoadingStatus.completed,
                                  child: MainButton(
                                    onTap:(){
                                    controller.isLastQuestion ? Get.toNamed(TestOverviewscreen.routeName) :
                                    controller.nextQuestion();
                                  },
                                  title:controller.isLastQuestion? 'completed': 'Next',
                                  
                            )
                         ),
                       )
                    ],
                  ),
                 ),
                )
              ]
             )
           )
          ),
        );
      }
    }

    