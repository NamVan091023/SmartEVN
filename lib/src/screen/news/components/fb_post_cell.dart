import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/facebook_response.dart';

class FBPostCell extends StatelessWidget {
  FBPostCell({Key? key, required this.fbNews, required this.onTap})
      : super(key: key);

  late final Function() onTap;
  late final FBNews fbNews;
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          // height: 120,
          padding: const EdgeInsets.all(5),
          child: IntrinsicHeight(
            child: Row(children: [
              Expanded(
                flex: 6,
                child: CachedNetworkImage(
                  imageUrl: fbNews.fullPicture ??
                      "https://via.placeholder.com/120/?text=Smart%20Environment",
                  placeholder: (c, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (c, e, f) => Center(child: Icon(Icons.error)),
                  fit: BoxFit.fill,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 14,
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        fbNews.message ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        fbNews.from?.name ?? "",
                        style: TextStyle(color: Colors.cyan),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(convertDate(fbNews.createdTime ?? "") ?? ""),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
