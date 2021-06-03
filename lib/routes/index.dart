import 'package:flutter_jd/pages/agreement/privacy.dart';
import 'package:flutter_jd/pages/blog/detail.dart';
import 'package:flutter_jd/pages/blog/index.dart';
import 'package:flutter_jd/pages/goods/goods_detail.dart';
import 'package:flutter_jd/pages/launch/index.dart';
import 'package:flutter_jd/pages/login/index.dart';
import 'package:flutter_jd/pages/order/index.dart';
import 'package:flutter_jd/pages/search/index.dart';
import 'package:flutter_jd/pages/setting/index.dart';
import 'package:flutter_jd/pages/tabbar/cart.dart';
import 'package:flutter_jd/pages/tabbar/category.dart';
import 'package:flutter_jd/pages/tabbar/find.dart';
import 'package:flutter_jd/pages/tabbar/home.dart';
import 'package:flutter_jd/pages/tabbar/my.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: '/launch_page', page: () => LaunchPage(), title: '启动页'),
    GetPage(name: '/', page: () => Home(), title: '首页'),
    GetPage(name: '/category', page: () => Category(), title: '分类'),
    GetPage(name: '/find', page: () => Find(), title: '发现'),
    GetPage(name: '/cart', page: () => Cart(), title: '购物车'),
    GetPage(name: '/my', page: () => My(), title: '我的'),
    GetPage(
      name: '/login',
      page: () => Login(),
      title: '登录',
      transitionDuration: Duration(milliseconds: 200),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    GetPage(name: '/setting', page: () => SettingPage(), title: '设置'),
    GetPage(name: '/search', page: () => SearchPage(), title: '搜索'),
    GetPage(name: '/goods_detail', page: () => GoodsDetail(), title: '商品详情'),
    GetPage(name: '/order', page: () => Order(), title: '订单'),
    GetPage(name: '/privacy', page: () => Privacy(), title: '隐私政策'),
    GetPage(name: '/blog', page: () => Blog(), title: '博客'),
    GetPage(name: '/blog_detail', page: () => BlogDetail(), title: '博客'),
  ];
}
