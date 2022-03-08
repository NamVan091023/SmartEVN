import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  const CardMenu(
      {Key? key,
      required this.text,
      required this.leftIcon,
      required this.right,
      this.onTap})
      : super(key: key);

  final String text;
  final Widget right;
  final Icon leftIcon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                leftIcon,
                SizedBox(width: 8),
                Expanded(child: Text(text)),
                SizedBox(width: 8),
                right
              ],
            ),
          ),
        ),
      ),
    );
  }
}
