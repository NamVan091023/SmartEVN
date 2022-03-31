import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/components/username.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/api_service.dart';

class PollutionUserCard extends StatelessWidget {
  PollutionUserCard({Key? key, required this.userModel, this.createdAt})
      : super(key: key);

  final UserModel? userModel;
  final String? createdAt;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10000.0),
              child: CachedNetworkImage(
                imageUrl: "$host/${userModel?.avatar}",
                placeholder: (c, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (c, e, f) => Center(
                    child: Icon(
                  Icons.person,
                  size: 50,
                )),
                fit: BoxFit.fill,
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dữ liệu được cung cấp bởi",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  UserName(user: userModel ?? UserModel(name: "Người nào đó")),
                  Text(
                    "Lúc: ${convertDate(createdAt ?? "")}",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}