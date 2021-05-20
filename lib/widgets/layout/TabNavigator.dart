import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/toolbar/cart.dart';
import 'package:flutter_jd/pages/toolbar/category.dart';
import 'package:flutter_jd/pages/toolbar/find.dart';
import 'package:flutter_jd/pages/toolbar/home.dart';
import 'package:flutter_jd/pages/toolbar/my.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(
    initialPage: 0, // 初始显示第0个tab
  );

  final _defaultColor = Color(0xFF222222);
  final _activeColor = Color(0xFFFB341F);
  int _currentIndex = 0;

  void _pageChange(int index) {
    setState(() {
      if (_currentIndex != index) {
        _currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: _pageChange,
          children: <Widget>[Home(), Category(), Find(), Cart(), My()],
          physics: NeverScrollableScrollPhysics(), // 禁止tab左右滑动
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
          },
          selectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomItem('首页', IconData(0xf02b, fontFamily: 'iconfont'), 0),
            _bottomItem('分类', IconData(0xe607, fontFamily: 'iconfont'), 1),
            _bottomItem('发现', IconData(0xe788, fontFamily: 'iconfont'), 2),
            _bottomItem('购物车', IconData(0xe611, fontFamily: 'iconfont'), 3),
            _bottomItem('我的', IconData(0xe600, fontFamily: 'iconfont'), 4),
          ],
        ),
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: new Transform(
        child: Icon(icon, color: _activeColor),
        alignment: Alignment.center,
        transform: new Matrix4.identity()..scale(1.1),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: _currentIndex != index ? _defaultColor : _activeColor,
        ),
      ),
    );
  }
}
