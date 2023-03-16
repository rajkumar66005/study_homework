import 'package:flutter/material.dart';
import 'package:study_homework/configs/themes/custom_text_style.dart';

class CountdownTimer extends StatelessWidget {
  final Color? color;
  final String time;

  const CountdownTimer({super.key,
  this.color,
  required this.time
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color??Theme.of(context).primaryColor,
        ),
        SizedBox(width: 5),
        Text(
          time,
          style:countdowntimerTxt().copyWith(color: color),
           )
      ],
    );
  }
}