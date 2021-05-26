import 'package:flutter/material.dart';
import 'package:flutter_jd/mock/text.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';

// 隐私政策
class Privacy extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<Privacy> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '隐私政策',
        isBack: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Column(
              children: [
                Container(
                  child: Text(
                    '用户注册及使用APP隐私协议',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    privacy,
                    style: TextStyle(height: 1.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
