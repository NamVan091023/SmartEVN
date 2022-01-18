import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';

class TwoTextLine extends StatelessWidget {
  const TwoTextLine({
    Key? key,
    required this.textOne,
    required this.textTwo,
  }) : super(key: key);
  final String textOne;
  final String textTwo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textOne,
          style: TextStyle(
            color: secondaryText,
            fontSize: secondaryTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          textTwo,
          style: TextStyle(
            color: Colors.green,
            fontSize: size12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
