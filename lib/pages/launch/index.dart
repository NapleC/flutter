import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/widgets/layout/TabNavigator.dart';

// 启动页
class LaunchPage extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<LaunchPage> {
  Timer _timer;
  int count = 3;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    //  隐藏状态栏，保留底部按钮栏
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          alignment: Alignment(1.0, -1.0), // 右上角对齐
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Image.asset(
                'assets/images/launch/ad.jpg',
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "$count 跳过",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  onPressed: () {
                    navigationPage();
                  },
                ),
              ),
            ),
          ],
        ),
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (cxt, ani1, ani2) {
          return FadeTransition(child: TabNavigator(), opacity: ani1);
        },
      ),
    );
  }
}
