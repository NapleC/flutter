import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/dio_utils.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';

// 博客
class Blog extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<Blog> {
  List list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    DioUtils.request(
      "/api/getBlogList",
      // "/api/getHotArticle",
      context: context,
      method: "GET",
      params: {},
      onSuccess: (res) {
        if (res['code'] == 1) {
          print(res['data']);
          setState(() {
            list = res['data'];
          });
        }
      },
      onError: (error) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '博客',
        isBack: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var item = list[index];
          return AspectRatio(
            aspectRatio: 3 / 1.8,
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Image.network(
                item['home_img'],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: list.length,
        // itemExtent: 50,
      ),
    );
  }
}
