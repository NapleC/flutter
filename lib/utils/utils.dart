import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_jd/utils/storage_util.dart';
import 'package:get/route_manager.dart';

class Utils {
  // iconFont 组件
  static Icon iconFont(int icon,
      [Color color = Colors.black45, double size = 15]) {
    return Icon(
      IconData(icon, fontFamily: 'iconfont'),
      color: color,
      size: size,
    );
  }

  // 判断当前是否处于degbu模式
  static bool isDebugMode() {
    return !bool.fromEnvironment("dart.vm.product");
  }

  // 颜色转换
  static Color hexToColor(String s) {
    return Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
  }

  // 简单文字提示
  static showText({String text, Alignment align, double radius = 5}) {
    BotToast.showText(
      duration: Duration(milliseconds: 2500),
      text: text.toString(),
      textStyle: TextStyle(
        fontSize: 13,
        color: Colors.white,
      ),
      clickClose: true,
      contentColor: Color.fromRGBO(0, 0, 0, 0.7),
      contentPadding: EdgeInsets.fromLTRB(15, 11, 15, 12),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      align: align ?? Alignment(0, 0),
    );
  }

  // 获取token
  static Future<String> getToken() async {
    return await StorageUtil.getStringItem('token') ?? '0';
  }

  static logOut() {
    StorageUtil.remove('token');
    StorageUtil.remove('uid');
  }

  // 选择弹窗
  static Future openAlert(String content, BuildContext context,
      {String title}) async {
    var action = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(content, style: TextStyle(fontSize: 14)),
            actions: <Widget>[
              FlatButton(
                child: Text('取消',
                    style: TextStyle(color: Utils.hexToColor('#333333'))),
                onPressed: () {
                  Get.back(result: '取消');
                },
              ),
              FlatButton(
                child: Text('确定',
                    style: TextStyle(color: Utils.hexToColor('#297CFF'))),
                onPressed: () {
                  Get.back(result: '确定');
                },
              ),
            ],
          );
        });

    if (action == '确定') {
      return true;
    } else if (action == '取消') {
      return false;
    } else {
      return false;
    }
  }

  // 隐藏键盘
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }
}
