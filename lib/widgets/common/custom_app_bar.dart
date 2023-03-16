import 'package:flutter/material.dart';
import 'package:study_homework/configs/themes/app_icons.dart';
import 'package:study_homework/configs/themes/custom_text_style.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';
import 'package:study_homework/screens/question/test_overview_screen.dart';
import 'package:study_homework/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titlewidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  const CustomAppBar({
    super.key,
    this.title= '',
    this.titlewidget,
    this.leading,
    this.showActionIcon=false,
    this.onMenuActionTap
    });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: mobileScreenPadding,
          vertical: mobileScreenPadding
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: titlewidget==null? Center(
                  child: Text(
                    title,
                    style:appBarText,
                  ),
              ) : Center(child: titlewidget)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading?? Transform.translate(offset: Offset(-14,0),
                child: BackButton() 
                ),
                if(showActionIcon)
                Transform.translate(offset: Offset(10,0),
                child: AppCircleButton(
                  onTap: onMenuActionTap ?? ()=> Get.toNamed(TestOverviewscreen.routeName),
                  child: const Icon(AppIcons.meunIconleft),
                  ),
                )
              ],
            )
          ],
        ),
      )
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(
    double.maxFinite,
    80
  );
}