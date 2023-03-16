import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/configs/themes/app_icons.dart';
import 'package:study_homework/configs/themes/app_light_theme.dart';
import 'package:study_homework/configs/themes/custom_text_style.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';
import 'package:study_homework/controller/question_paper/question_paper_controller.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:study_homework/controller/zoom_drawer_controller.dart';
import 'package:study_homework/models/question_paper_model.dart';
import 'package:study_homework/rough_work.dart';
import 'package:study_homework/screens/home/menu_screen.dart';
import 'package:study_homework/screens/home/question_card.dart';
import 'package:study_homework/widgets/app_circle_button.dart';
import 'package:study_homework/widgets/content_area.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

static const String routeName="/home";

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();

    return Scaffold(
        body:GetBuilder<MyZoomDrawerController>(builder:(_){
        return  ZoomDrawer( 
          borderRadius: 24,
          controller: _.zoomDrawerController,
          showShadow: true,
          angle: 0.0,
          style: DrawerStyle.defaultStyle,
          duration: const Duration(milliseconds: 500),
          openCurve: Curves.fastOutSlowIn,
          slideWidth: MediaQuery.of(context).size.width*0.8,
          menuBackgroundColor: Colors.black,
          
           menuScreen: MyMenuScreen(),
           mainScreen: Container(
           decoration: BoxDecoration(gradient: mainGradient()),        
           child:SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(mobileScreenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCircleButton(
                          onTap: controller.toogleDrawer,
                          child:  const Icon(AppIcons.meunIconleft , size: 15,),
                          ),
                        const SizedBox( height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                              children: [
                                const Icon(AppIcons.peace),
                                Text("hello friends",
                                     style: detailText.copyWith(
                                      color: onSurfaceTextColor
                                     ))
                              ],
                          ),
                        ),
                        const Text("What do you want to learn Today?",
                        style: headerText,
                        ),                       
                      ],
                      
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ContentArea(
                        addPadding: false,
                        child: Obx(() =>  ListView.separated(
                          padding: UIparameters.mobileScreenPadding,
                          itemBuilder:(BuildContext context, int index)  {
                              return QuestionCard( model:_questionPaperController.allPapers[index]);
                          },
                          separatorBuilder:(BuildContext context, int index) {
                              return const SizedBox(height: 10);
                          },
                           itemCount: _questionPaperController.allPapers.length
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
               ),
         );
         })
    );
    
  } 
}
