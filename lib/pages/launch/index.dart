import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/widgets/layout/TabNavigator.dart';
import 'package:get/route_manager.dart';

// 启动页/广告页
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
    setStatus();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
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
              bottom: 40,
              right: 20,
              // ignore: deprecated_member_use
              child: FlatButton(
                minWidth: 80,
                height: 34,
                padding: EdgeInsets.only(bottom: 2),
                color: Color.fromRGBO(0, 0, 0, 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$count 跳过",
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ),
                onPressed: () {
                  toHomePage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 隐藏状态栏，保留底部按钮栏
  void setStatus() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  // 设置启动图时间
  void startTime() async {
    Timer(Duration(milliseconds: 0), () {
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
        setState(() {
          --count;
        });
        if (count == 0) {
          Timer(Duration(milliseconds: 500), () {
            toHomePage();
          });
        }
      });
      return _timer;
    });
  }

  // 跳转到主页
  void toHomePage() {
    print(_timer);
    if (_timer != null) {
      _timer.cancel();
      SystemChrome.setEnabledSystemUIOverlays(
        SystemUiOverlay.values,
      );

      Get.off(
        () => new TabNavigator(),
        duration: Duration(milliseconds: 600),
        transition: Transition.noTransition,
      );
    }
  }
}
