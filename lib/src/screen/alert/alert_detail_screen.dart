import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/components/full_image_viewer.dart';
import 'package:pollution_environment/src/model/alert_model.dart';

class AlertDetailScreen extends StatelessWidget {
  final Alert alert;
  const AlertDetailScreen({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chi tiết cảnh báo")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(alert.title ?? "",
                style: Theme.of(context).textTheme.headline6),
            SizedBox(
              height: 10,
            ),
            Text(
              alert.content ?? "",
            ),
            SizedBox(
              height: 10,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: CachedNetworkImage(
                  imageUrl: alert.images![index],
                  placeholder: (c, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (c, e, f) => Center(child: Icon(Icons.error)),
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  Get.to(() => FullImageViewer(
                        url: alert.images![index],
                      ));
                },
              ),
              physics:
                  NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              itemCount: alert.images?.length ?? 0,
            )
          ],
        ),
      ),
    );
  }
}
