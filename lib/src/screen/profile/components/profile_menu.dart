import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        // padding: EdgeInsets.all(20),

        // style: ButtonStyle(
        //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(15))),
        //     backgroundColor:
        //         MaterialStateProperty.all(Theme.of(context).cardColor)),
        onPressed: press,
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: Theme.of(context).primaryIconTheme.color,
                width: 22,
              ),
              SizedBox(width: 20),
              Expanded(child: Text(text)),
              Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
