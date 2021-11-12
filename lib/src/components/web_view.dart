import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/cupertino.dart';

class MyWebView extends StatefulWidget {
  final url;
  MyWebView(this.url);
  @override
  createState() => _MyWebView(this.url);

}

class _MyWebView extends State<MyWebView> {

  var _url;
  final _key = UniqueKey();
  @override
  _MyWebView(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
  
}