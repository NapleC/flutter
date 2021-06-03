import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';
import 'package:get/route_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 博客详情
class BlogDetail extends StatefulWidget {
  // final int id;
  // BlogDetail({Key key, this.id}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<BlogDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '博客详情',
        isBack: true,
      ),
      body: WebView(
        initialUrl: 'https://www.lingchen.kim/Detail?id=${Get.arguments['id']}',
      ),
    );
  }
}
