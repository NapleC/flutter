import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/mock/mock.dart';
import 'package:flutter_jd/utils/utils.dart';

//滚动最大距离
const APPBAR_SCROLL_OFFSET = 100;

class My extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<My> {
  double appBarAlpha = 0;
  int _currentPageIndex = 0;
  List topList = [
    {'title': '商品收藏', 'num': '35'},
    {'title': '店铺关注', 'num': '23'},
    {'title': '喜欢对内容', 'num': '12'},
    {'title': '浏览记录', 'num': '56'},
  ];
  List orderList = [
    {'name': '代付款', 'icon': 0xe624},
    {'name': '待收货', 'icon': 0xe622},
    {'name': '待评价', 'icon': 0xe61e},
    {'name': '退换/售后', 'icon': 0xe619},
    {'name': '我的订单', 'icon': 0xe8cd},
  ];

  List moneyList = [
    {'title': '7993', 'name': '京豆', 'subText': '签到领京豆'},
    {'title': '11', 'name': '优惠券', 'subText': ''},
    {'title': '7', 'name': '白条', 'subText': '还款倒计时'},
    {'title': '1.77', 'name': '京东金条', 'subText': '秒批额度'},
    {'title': '2.3', 'name': '我的钱包', 'subText': ''}
  ];

  List productList = PRODUCT_LIST;

  List toolsList = [
    {'title': '京东超市', 'icon': 'assets/images/tools/tool_1.png'},
    {'title': '京东电器', 'icon': 'assets/images/tools/tool_2.png'},
    {'title': '潮流服饰', 'icon': 'assets/images/tools/tool_3.png'},
    {'title': '免费水果', 'icon': 'assets/images/tools/tool_4.png'},
    {'title': '京东到家', 'icon': 'assets/images/tools/tool_5.png'},
    {'title': '生活服务', 'icon': 'assets/images/tools/tool_6.png'},
    {'title': '领京豆', 'icon': 'assets/images/tools/tool_7.png'},
    {'title': '领劵', 'icon': 'assets/images/tools/tool_8.png'},
    {'title': '借钱', 'icon': 'assets/images/tools/tool_9.png'},
    {'title': 'PLUS会员', 'icon': 'assets/images/tools/tool_10.png'},
  ];

  Widget _buildTopBar() {
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        padding: EdgeInsets.only(top: 32, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFF9F9F9),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 90,
              child: Row(
                children: [Utils.iconFont(0xe600, Color(0xFF333333), 20)],
              ),
            ),
            Text(
              "我的",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/setting");
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Utils.iconFont(0xe612, Color(0xFF333333), 20),
                    ),
                  ),
                  Utils.iconFont(0xe8b8, Color(0xFF333333), 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _productList() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.only(left: 12, right: 10, top: 10),
        child: Text(
          '常逛常用',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        height: 955,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: 7 / 8.9,
          ),
          physics: NeverScrollableScrollPhysics(),
          children: _buildProductList(),
        ),
      ),
    ]);
  }

  List<Widget> _buildProductList() {
    List<Widget> list = [];

    for (var i = 0; i < productList.length; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/goods_detail", arguments: {
              'imgUrl': productList[i]['src'],
              'name': productList[i]['name'],
              'price': productList[i]['price'],
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 0.93,
                  child: Container(child: Image.asset(productList[i]['src'])),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    productList[i]['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, top: 3),
                  child: Row(
                    children: [
                      Text(
                        '¥',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        productList[i]['price'],
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '.00',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return list;
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;

    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 0.9;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildOrderCard() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(left: 10, right: 10, top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(
          orderList.length,
          (index) => Expanded(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Utils.iconFont(orderList[index]['icon'], Color(0xFF333333), 25),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    orderList[index]['name'],
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  _buildMoneyCard() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(left: 10, right: 10, top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(
          moneyList.length,
          (index) => Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    moneyList[index]['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    moneyList[index]['name'],
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    moneyList[index]['subText'],
                    style: TextStyle(color: Color(0xFF999999), fontSize: 10),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  _buildToolsCard() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: PageView(
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index % (2);
                });
              },
              children: <Widget>[
                Container(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 15,
                      childAspectRatio: 7 / 7.2,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    children: _buildIconList(toolsList),
                  ),
                ),
                Container(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 15,
                      childAspectRatio: 7 / 7.2,
                    ),
                    children: _buildIconList(toolsList),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (i) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPageIndex == i
                        ? Color(0xFFFd3D29)
                        : Color(0xFFE3E3E3),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  _buildIconList(iconList) {
    List<Widget> list = [];

    for (var i = 0; i < iconList.length; i++) {
      var src = iconList[i]['icon'];
      var text = iconList[i]['title'];

      list.add(
        Container(
          child: Column(
            children: [
              Container(
                width: 30,
                child: Image.asset(src),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        child: Scaffold(
          body: Stack(children: <Widget>[
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              //监听列表的滚动
              child: NotificationListener(
                //监听滚动后要调用的方法
                // ignore: missing_return
                onNotification: (scrollNotification) {
                  //只有当是更新状态下和是第0个child的时候才会调用
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: SingleChildScrollView(
                  child: Container(
                    color: Color(0xFFF2F2F2),
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            width: double.infinity,
                            height: 230,
                            child: Image.asset(
                              'assets/images/my_bg.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQueryData.fromWindow(window)
                                      .padding
                                      .top +
                                  15,
                              left: 15,
                              right: 12,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.asset(
                                              'assets/images/avatar.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: Text(
                                            '一颗稀仔',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 90,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/setting");
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 12),
                                              child: Utils.iconFont(
                                                  0xe612, Colors.white, 20),
                                            ),
                                          ),
                                          Utils.iconFont(
                                            0xe8b8,
                                            Colors.white,
                                            20,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.only(top: 45),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      topList.length,
                                      (index) => Container(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              topList[index]['num'].toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                topList[index]['title'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        _buildOrderCard(),
                        _buildMoneyCard(),
                        _buildToolsCard(),
                        _productList()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildTopBar()
          ]),
        ),
      ),
    );
  }
}
