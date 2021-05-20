import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/mock/mock.dart';
import 'package:flutter_jd/utils/utils.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 轮播图数据
  List bannerList = BANNER_LIST;
  // 应用列表1
  List appList1 = TOOLS_LIST1;
  // 应用列表2
  List appList2 = TOOLS_LIST2;
  // 应用列表当前索引
  int appListCurInd = 0;
  // 商品列表
  List goodsList = PRODUCT_LIST;

  // 搜索栏
  Widget _buildSearch() {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 5),
      color: Color(0xFFFC3A26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 32,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 12, right: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Utils.iconFont(0xe692, Color(0xFF999999)),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          '机械键盘',
                          style:
                              TextStyle(color: Color(0xFF999999), fontSize: 14),
                        ),
                      ),
                    )),
                    Utils.iconFont(0xe614, Color(0xFF999999), 16),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  print('扫一扫');
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Utils.iconFont(0xe8b6, Colors.white, 22),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('消息');
                },
                child: Container(
                  child: Utils.iconFont(0xe8b8, Colors.white, 22),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 轮播图
  Widget _buildBanner() {
    return Stack(
      children: [
        Container(
          child: ClipPath(
            clipper: BackgroundClipper(),
            child: Container(
              width: double.infinity,
              height: 120,
              color: Color(0xFFFC3A26),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 140,
          child: Swiper(
            itemCount: bannerList.length,
            autoplay: true,
            autoplayDelay: 5000,
            duration: 800,
            // viewportFraction: 0.8, // 显示多张图片
            // scale: 0.85, // 图片左右间距 (打开此属性切换页面会报错)
            // pagination: new SwiperPagination(),
            pagination: new SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) {
              return Positioned(
                left: 0,
                right: 0,
                bottom: 7,
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _bannerPagetion(config.itemCount, config.activeIndex)
                  ],
                )),
              );
            }),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Color(0xffeeeeee),
                    child: Image.asset(
                      bannerList[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 轮播图分页小圆点
  Widget _bannerPagetion(int count, int activeIndex) {
    List<Widget> list = [];

    for (var i = 0; i < count; i++) {
      list.add(new Container(
        width: 6,
        height: 6,
        margin: EdgeInsets.only(right: i + 1 != count ? 5 : 0),
        decoration: BoxDecoration(
          color: activeIndex == i ? Color(0xfff2534e) : Color(0xffe0d7ce),
          borderRadius: BorderRadius.circular(45),
        ),
      ));
    }

    return Row(children: list);
  }

  Widget _scrollXIcon() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 155,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: PageView(
              onPageChanged: (int index) {
                setState(() {
                  appListCurInd = index % (2);
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
                    children: _buildIconList(appList1),
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
                    children: _buildIconList(appList2),
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
                    color: appListCurInd == i
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

  List<Widget> _buildIconList(iconList) {
    List<Widget> list = [];

    for (var i = 0; i < iconList.length; i++) {
      var src = iconList[i]['icon'];
      var text = iconList[i]['title'];

      list.add(
        Container(
          child: Column(children: [
            Container(
              width: 40,
              child: Image.asset(src),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            )
          ]),
        ),
      );
    }

    return list;
  }

  // 秒杀
  _buildSeckill() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 8),
            child: Row(
              children: [
                Text(
                  '京东秒杀',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    '20',
                    style: TextStyle(
                      color: Utils.hexToColor('#FB341F'),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 22,
                  child: Image.asset('assets/images/ms.png', fit: BoxFit.cover),
                ),
                Row(
                  children: [
                    _buildCountDown('00', 10),
                    _buildListCardSplit(),
                    _buildCountDown('08', 0),
                    _buildListCardSplit(),
                    _buildCountDown('12', 0)
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 195,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                PRODUCT_LIST.length,
                (index) => Container(
                  child: Image.asset(PRODUCT_LIST[index]['src']),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildCountDown(String time, double left) {
    return Container(
      width: 17,
      height: 17,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: left),
      decoration: BoxDecoration(
        color: Utils.hexToColor('#FB4321'),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _buildListCardSplit() {
    return Container(
      padding: EdgeInsets.all(3),
      child: Text(
        ':',
        style: TextStyle(
          color: Utils.hexToColor('#FB4321'),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 商品列表
  Widget _buildGoodsList() {
    return Container(
      height: 955,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 7 / 8.9,
        ),
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          goodsList.length,
          (i) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/goods_detail", arguments: {
                'imgUrl': goodsList[i]['src'],
                'name': goodsList[i]['name'],
                'price': goodsList[i]['price'],
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
                    child: Container(child: Image.asset(goodsList[i]['src'])),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      goodsList[i]['name'],
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
                    padding: EdgeInsets.only(left: 8, top: 3),
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
                          goodsList[i]['price'],
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        height: 0,
        brightness: Brightness.dark,
        backgroundColor: Color(0xFFFC3A26),
      ),
      body: Column(
        children: [
          _buildSearch(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xFFF2F2F2),
                child: Column(
                  children: [
                    _buildBanner(),
                    _scrollXIcon(),
                    _buildSeckill(),
                    _buildGoodsList()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 顶部背景圆弧
class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height / 1.2);

    path.cubicTo(
      size.width / 15,
      size.height,
      size.width / 10 * 12,
      size.height / 3 * 3,
      size.width,
      size.height / 10000,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
