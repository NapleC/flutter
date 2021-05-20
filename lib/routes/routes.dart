import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/goods/goods_detail.dart';
import 'package:flutter_jd/pages/login/index.dart';
import 'package:flutter_jd/pages/search/index.dart';
import 'package:flutter_jd/pages/toolbar/cart.dart';
import 'package:flutter_jd/pages/toolbar/category.dart';
import 'package:flutter_jd/pages/toolbar/find.dart';
import 'package:flutter_jd/pages/toolbar/home.dart';
import 'package:flutter_jd/pages/toolbar/my.dart';
import 'package:flutter_jd/pages/setting/index.dart';

final routes = {
  '/': (context) => Home(),
  '/category': (context) => Category(),
  '/find': (context) => Find(),
  '/cart': (context) => Cart(),
  '/my': (context) => My(),
  '/login': (context) => Login(),
  '/setting': (context) => SettingPage(),
  '/search': (context) => SearchPage(),
  '/goods_detail': (context, {arguments}) => GoodsDetail(arguments: arguments),
};

//统一处理命名路由
var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    //能寻找到对应的路由
    if (settings.arguments != null) {
      //页面跳转前有传参
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      //页面跳转前没有传参
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
