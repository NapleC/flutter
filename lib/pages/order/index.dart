import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/mock/mock.dart';
import 'package:flutter_jd/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// 订单
class Order extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<Order> with SingleTickerProviderStateMixin {
  List tabs = ['全部', '待付款', '待收货', '已完成', '已取消'];
  List tabsStatus = [
    {'status': 'accept', 'index': 0},
    {'status': 'check', 'index': 1},
    {'status': 'checked', 'index': 2},
    {'status': 'checked', 'index': 3},
    {'status': 'checked', 'index': 4},
  ];
  final SlidableController slidableController = SlidableController();
  bool isSelectAll = false;
  double totalPrice = 0;
  int selectedNumber = 0;
  List productList = cartProductList;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 获取选中店铺数量
  int getSelectedStoreNumber() {
    int count = 0;
    for (var i = 0; i < productList.length; i++) {
      if (productList[i]['isSelected']) {
        ++count;
      }
    }
    return count;
  }

  _buildItem(int index, int cIndex) {
    var item = productList[index]['children'][cIndex];

    return Container(
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/goods_detail", arguments: {
                      'imgUrl': item['src'],
                      'name': item['name'],
                      'price': item['price'],
                    });
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(item['src']),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            item['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建头部按钮
  _buildHeadLeftBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Utils.iconFont(0xe671, Color(0xFF333333), 18),
      ),
    );
  }

  _buildSearchBar() {
    return Container(
      height: 40,
      padding: EdgeInsets.only(right: 10, bottom: 5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 35,
            child: _buildHeadLeftBtn(),
          ),
          Expanded(
            child: Container(
              height: 32,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Utils.iconFont(0xe692, Color(0xFF999999), 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/search');
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            '搜索我的订单',
                            style: TextStyle(color: Color(0xFF999999)),
                          ),
                        ),
                      ),
                    ),
                    Utils.iconFont(0xe614, Color(0xFF999999), 15),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Utils.iconFont(0xe8b8, Color(0xFF999999), 22),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildSearchBar(),
                Expanded(
                  child: DefaultTabController(
                    length: tabs.length,
                    initialIndex: 0,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.red,
                          indicatorSize: TabBarIndicatorSize.values[1],
                          labelColor: Colors.red,
                          unselectedLabelColor: Colors.black,
                          indicatorWeight: 3.0,
                          labelStyle: TextStyle(
                            fontSize: 15,
                            height: 2,
                          ),
                          tabs: tabs.map((f) {
                            return Text(f);
                          }).toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: tabs.map((item) {
                              return Container(
                                color: Color(0xFFF6F6F6),
                                child: ListView(
                                  // itemExtent: 150,
                                  children: List.generate(
                                    productList.length,
                                    (index) => Container(
                                      margin: EdgeInsets.only(
                                          top: index == 0 ? 10 : 0, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            color: Colors.white,
                                            padding: EdgeInsets.only(
                                              top: 15,
                                              left: 15,
                                              bottom: 12,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 12),
                                                  child: Text(
                                                    productList[index]['title'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: List.generate(
                                              productList[index]['children']
                                                  .length,
                                              (cIndex) => Container(
                                                height: 130,
                                                color: Colors.white,
                                                child: _buildItem(
                                                  index,
                                                  cIndex,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
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
