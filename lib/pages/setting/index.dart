import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/utils.dart';
import 'package:flutter_jd/widgets/common/ShowAniationDialog.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';
import 'package:get/route_manager.dart';

// 设置
class SettingPage extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<SettingPage> {
  List cardList1 = [
    {
      'name': '账户与安全',
      'page': '',
    },
    {
      'name': '设置字体大小',
      'page': '',
    },
    {
      'name': '支付设置',
      'page': '',
    },
    {
      'name': '发票抬头管理',
      'page': '',
    },
    {
      'name': '我的档案',
      'page': '',
    },
    {
      'name': '通用',
      'page': '',
    },
  ];

  List cardList2 = [
    {
      'name': 'PLUS会员',
      'page': '',
    },
    {
      'name': '家庭号设置',
      'page': '',
    },
    {
      'name': '功能实验室',
      'page': '',
    },
    {
      'name': '功能反馈',
      'page': '',
    },
    {
      'name': '关于APP',
      'page': '',
    },
    {
      'name': '开发者博客',
      'page': '/blog',
    }
  ];

  _buildCard(List list) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: List.generate(
          list.length,
          (index) => GestureDetector(
            onTap: () {
              String page = list[index]['page'];
              if (page != '') {
                Get.toNamed(page);
              }
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: list.length != index
                        ? Color(0xFFF8F8F8)
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    list[index]['name'],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Utils.iconFont(0xe7e7, Color(0xFF888888), 16)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(TransitionType type) {
    showAnimationDialog(
      context: context,
      transitionType: type,
      builder: (context) {
        return Dialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 130,
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Text(
                  '确定要退出登录？',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 90,
                          height: 30,
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.red, width: 1),
                          ),
                          child: Text(
                            '取消',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed('/login');
                        },
                        child: Container(
                          width: 90,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFA2F19),
                                Color(0xFFFA722E),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            '确定',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '账户设置',
        isBack: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCard(cardList1),
            _buildCard(cardList2),
            GestureDetector(
              onTap: () {
                _showDialog(TransitionType.scale);
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '退出登录',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
