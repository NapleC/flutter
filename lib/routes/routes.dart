import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/agreement/privacy.dart';
import 'package:flutter_jd/pages/goods/goods_detail.dart';
import 'package:flutter_jd/pages/launch/index.dart';
import 'package:flutter_jd/pages/login/index.dart';
import 'package:flutter_jd/pages/order/index.dart';
import 'package:flutter_jd/pages/search/index.dart';
import 'package:flutter_jd/pages/tabbar/cart.dart';
import 'package:flutter_jd/pages/tabbar/category.dart';
import 'package:flutter_jd/pages/tabbar/find.dart';
import 'package:flutter_jd/pages/tabbar/home.dart';
import 'package:flutter_jd/pages/tabbar/my.dart';
import 'package:flutter_jd/pages/setting/index.dart';

final routes = {
  '/launch_page': (context) => LaunchPage(),
  '/': (context) => Home(),
  '/category': (context, {arguments}) => Category(arguments: arguments),
  '/find': (context) => Find(),
  '/cart': (context) => Cart(),
  '/my': (context) => My(),
  '/login': (context) => Login(),
  '/setting': (context) => SettingPage(),
  '/search': (context) => SearchPage(),
  '/goods_detail': (context, {arguments}) => GoodsDetail(arguments: arguments),
  '/order': (context) => Order(),
  '/privacy': (context) => Privacy(),
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
        builder: (context) => pageContentBuilder(
          context,
          arguments: settings.arguments,
        ),
      );
      return route;
    } else {
      //页面跳转前没有传参
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  }
};
