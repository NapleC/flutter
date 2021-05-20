import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_jd/widgets/layout/TabNavigator.dart';

class Ad extends StatefulWidget {
  static const String routeName = '/ad';
  @override
  _AdState createState() => _AdState();
}

class _AdState extends State<Ad> {
  Timer _timer;
  int count = 3;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment(1.0, -1.0), // 右上角对齐
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              'assets/images/ad.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 35,
            right: 20,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 0.0),
              child: FlatButton(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "$count 跳过",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                onPressed: () {
                  navigationPage();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 1);
    Timer(_duration, () {
      // 空等1秒之后再计时
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
        count--;
        if (count == 0) {
          navigationPage();
        } else {
          setState(() {});
        }
      });
      return _timer;
    });
  }

  void navigationPage() {
    _timer.cancel();
    Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (cxt, ani1, ani2) {
      return FadeTransition(child: TabNavigator(), opacity: ani1);
    }));
  }
}
