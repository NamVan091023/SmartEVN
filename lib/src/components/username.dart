import 'package:flutter/material.dart';
import 'package:pollution_environment/src/model/user_response.dart';

class UserName extends StatelessWidget {
  UserName({Key? key, required this.user}) : super(key: key);
  late final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          user.name ?? "",
          textAlign: TextAlign.center,
          style: user.role == 'admin'
              ? Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.red, fontWeight: FontWeight.w600)
              : Theme.of(context).textTheme.subtitle1,
        ),
        if (user.isEmailVerified == true)
          Icon(
            Icons.verified_user_rounded,
            color: Colors.green,
          ),
      ],
    );
  }
}