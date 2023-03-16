import 'package:flutter/material.dart';
import 'package:study_homework/configs/themes/app_colors.dart';
import 'package:study_homework/configs/themes/ui_parameters.dart';

enum AnswerStatus{
  correct , wrong , answered , notanswered
}

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerCard({
    super.key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,

    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIparameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
          child: Text(
            answer,
            style: TextStyle(
              color: isSelected?onSurfaceTextColor:null,

            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: UIparameters.cardBorderRadius,
            color: isSelected? answerSelectedcolor(): Theme.of(context).cardColor,
            border: Border.all(
              color: isSelected? answerSelectedcolor() : answerBordercolor()
            )
            
          ),
      ),
    );
  }
} 


class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({super.key , required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIparameters.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1)
      ),
      padding: EdgeInsets.symmetric(vertical:20, horizontal: 10),
      child: 
      Text(
        answer,
        style: const TextStyle(
         color : correctAnswerColor,
         fontWeight: FontWeight.bold
        ),
      ),

    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({super.key , required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIparameters.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1)
      ),
      padding: const EdgeInsets.symmetric(vertical:20, horizontal: 10),
      child: 
      Text(
        answer,
        style: const TextStyle(
         color : wrongAnswerColor,
         fontWeight: FontWeight.bold
        ),
      ),

    );
  }
}

class NotAnswered extends StatelessWidget {
  const NotAnswered({super.key , required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIparameters.cardBorderRadius,
        color: notAnsweredColor.withOpacity(0.1)
      ),
      padding: const EdgeInsets.symmetric(vertical:20, horizontal: 10),
      child: 
      Text(
        answer,
        style: const TextStyle(
         color : notAnsweredColor,
         fontWeight: FontWeight.bold
        ),
      ),

    );
  }
}
