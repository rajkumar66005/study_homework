import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:study_homework/configs/themes/app_icons.dart';
import 'package:study_homework/configs/themes/custom_text_style.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';
import 'package:study_homework/controller/question_paper/question_paper_controller.dart';
import 'package:study_homework/models/question_paper_model.dart';
import 'package:get/get.dart';
import 'package:study_homework/widgets/app_icon_text.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  const QuestionCard({super.key , required this.model});

  final QuestionPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding =10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIparameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        onTap: (){
          controller.navigateToQuestions(paper:model);
        },
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        width: Get.width*0.15, 
                        height: Get.width*0.15,              
                         child: CachedNetworkImage(
                            imageUrl:model.imageUrl!,
                            placeholder: (context ,url)=> Container(
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            ),
                            errorWidget:(context, url, error) => Image.asset("assets/images/app_splash_logo.png"),
                        )
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                 child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: cartStyle(context)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 15),
                        child: Text(model.description)
                      ),
                      Row( 
                        children: [
                            AppIconText(
                              icon: Icon(Icons.help_outline_sharp ,
                                    color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor),
                             text: Text('${model.questionCount} questions',
                                    style: detailText.copyWith(
                                      color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor
                                    ) )
                             ),
                             const SizedBox(width: 15),
                             AppIconText(
                              icon: Icon(Icons.timer ,
                                    color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor),
                             text: Text(model.timeInMinits(),
                                    style: detailText.copyWith(
                                      color: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor
                                    ) )
                             )
                        ],
                      )
                    ],
                  ) 
                  )
                ],
              ),
              Positioned(
                bottom: -_padding,
                right: -_padding,
                child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                  child: Icon(AppIcons.trouphyOutLine),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(cardBorderRadius),
                      bottomRight: Radius.circular(cardBorderRadius)
                    ),
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}