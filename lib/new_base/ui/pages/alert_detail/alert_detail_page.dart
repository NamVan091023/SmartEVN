import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pollution_environment/new_base/models/entities/alert_entity.dart';
import 'package:pollution_environment/new_base/routes/router_paths.dart';

import 'alert_detail_cubit.dart';

class AlertDetailArguments {
  final AlertEntity alertInfo;

  AlertDetailArguments({
    required this.alertInfo,
  });
}

class AlertDetailPage extends StatelessWidget {
  final AlertDetailArguments arguments;

  const AlertDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AlertDetailCubit();
      },
      child: AlertDetailChildPage(
        arguments: arguments,
      ),
    );
  }
}

class AlertDetailChildPage extends StatefulWidget {
  final AlertDetailArguments arguments;

  const AlertDetailChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<AlertDetailChildPage> createState() => _AlertDetailChildPageState();
}

class _AlertDetailChildPageState extends State<AlertDetailChildPage> {
  late final AlertDetailCubit _cubit;
  late AlertEntity alertInfo;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    alertInfo = widget.arguments.alertInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết cảnh báo",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              alertInfo.title ?? "",
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                alertInfo.content ?? "",
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: CachedNetworkImage(
                  imageUrl: alertInfo.images![index],
                  placeholder: (c, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (c, e, f) =>
                      const Center(child: Icon(Icons.error)),
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  context.push(RouterPaths.imageViewer);
                },
              ),
              physics: const NeverScrollableScrollPhysics(),
              // to disable GridView's scrolling
              shrinkWrap: true,
              itemCount: alertInfo.images?.length ?? 0,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
