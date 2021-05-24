import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/utils/utils.dart';

// 商品详情
class GoodsDetail extends StatefulWidget {
  final Map arguments;
  GoodsDetail({Key key, this.arguments}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<GoodsDetail> {
  // 滚动最大距离
  double appbarScrollOffset = 150;
  // 透明值
  double appBarAlpha = 0;

  _onScroll(offset) {
    double alpha = offset / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  _buildTopBar() {
    return Container(
      height: 80,
      padding: EdgeInsets.fromLTRB(
          0, MediaQueryData.fromWindow(window).padding.top, 12, 0),
      color: Colors.white.withOpacity(appBarAlpha),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: double.infinity,
          padding: EdgeInsets.only(left: 5, right: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.transparent,
              child: Utils.iconFont(0xe671, Color(0xFF333333), 18),
            ),
          ),
        ),
        Container(
          width: 90,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Utils.iconFont(0xe625, Color(0xFF333333), 18),
            ),
            Utils.iconFont(0xe6d3, Color(0xFF333333), 18),
          ]),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Material(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(children: <Widget>[
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
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(top: 15),
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    child: Image.asset(
                                      widget.arguments['imgUrl'],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10),
                                    right: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '¥',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          widget.arguments['price'].toString(),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '.00',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        widget.arguments['name'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Text(
                                        '抢券立减900元，限时套装特惠，加599起得AirPods套装！春季新配色紫色火热抢购中！更多优惠！ ',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Color(0xFF999999),
                                          fontSize: 11.5,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        '查看>',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 11.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 55,
                                margin: EdgeInsets.only(top: 12),
                                padding: EdgeInsets.fromLTRB(18, 12, 10, 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10),
                                    right: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 17,
                                      height: 17,
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
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Utils.iconFont(
                                        0xe604,
                                        Colors.white.withOpacity(0.9),
                                        11,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        '排行榜',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 12),
                                        child: Text(
                                          '98%用户好评创意配件热卖排行榜第 3 名',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Utils.iconFont(
                                        0xe7e7,
                                        Colors.black,
                                        16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildTopBar()
                ]),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 5, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Utils.iconFont(
                                        0xe70a, Color(0xFF333333), 22),
                                    Container(
                                      child: Text(
                                        '店铺',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Utils.iconFont(
                                        0xe8cf, Color(0xFF333333), 22),
                                    Container(
                                      child: Text(
                                        '客服',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Utils.iconFont(
                                        0xe621, Color(0xFF333333), 22),
                                    Container(
                                      child: Text(
                                        '购物车',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 35,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFF20300),
                                        Color(0xFFFE4C16),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '加入购物车',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFFA800),
                                        Color(0xFFFEBB00),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '立即购买',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQueryData.fromWindow(window).padding.bottom,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
