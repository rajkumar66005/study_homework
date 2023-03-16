import 'package:flutter/material.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';

class ContentArea extends StatelessWidget {
  const ContentArea(
    {super.key,
     required this.child,
      this.addPadding=true
      });

  final bool addPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top:Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: customScaffold(context)
        ),
        padding: addPadding?EdgeInsets.only(
          top: mobileScreenPadding,
          left: mobileScreenPadding,
          right: mobileScreenPadding
          )
          :EdgeInsets.zero,

        child: child,
      ),
    );
  }
}