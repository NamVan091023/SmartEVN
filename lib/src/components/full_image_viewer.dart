import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullImageViewer extends StatelessWidget {
  const FullImageViewer({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hình ảnh"),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (c, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (c, e, f) => Center(child: Icon(Icons.error)),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
