import 'package:flutter/material.dart';
import 'package:flutter_jd/mock/mock.dart';
import 'package:flutter_jd/utils/utils.dart';
import 'package:flutter_jd/widgets/common/PullRefresh.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 购物车
class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<Cart> {
  final SlidableController slidableController = SlidableController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isSelectAll = false;
  double totalPrice = 0;
  int selectedNumber = 0;
  List productList = cartProductList;
  List slideButtonList = [
    {
      'name': '设置\n常买',
      'type': '1',
      'textColor': Colors.black,
      'color': [Color(0xFFF0F0F0), Color(0xFFF0F0F0)]
    },
    {
      'name': '移入\n关注',
      'type': '2',
      'textColor': Colors.white,
      'color': [Color(0xFFFEB600), Color(0xFFFFD75A)]
    },
    {
      'name': '看相似',
      'type': '3',
      'textColor': Colors.white,
      'color': [Color(0xFFFF6223), Color(0xFFFF7F46)]
    },
    {
      'name': '删除',
      'type': '4',
      'textColor': Colors.white,
      'color': [Color(0xFFF22300), Color(0xFFFE4614)]
    }
  ];

  // 下拉刷新
  _onRefresh() async {
    _refreshController.loadComplete();
    // _loadData();

    await Future.delayed(Duration(milliseconds: 600));
    _refreshController.refreshCompleted();
  }

  // 加载更多
  _onLoading() async {
    await Future.delayed(Duration(milliseconds: 200));
    _refreshController.loadNoData();

    // if(currentPage == lastPage) {
    //   _refreshController.loadNoData();
    //   return;
    // }

    // // 加载更多数据
    // if(currentPage < lastPage) {
    //   _loadData(loadMore: true);
    //   _refreshController.loadComplete();
    // }
  }

  // 店铺商品勾选
  _buildTitleCheckBox(int index) {
    bool isSelected = productList[index]['isSelected'];

    return GestureDetector(
      onTap: () {
        setState(() {
          productList[index]['isSelected'] = !isSelected;
        });

        // 选中/取消选中店铺下面的商品
        List children = productList[index]['children'];
        double allPrice = 0;

        for (var i = 0; i < children.length; i++) {
          if (children[i]['isSelected']) {
            setState(() {
              totalPrice -= children[i]['price'] * children[i]['num'];
            });
          }

          setState(() {
            children[i]['isSelected'] = !isSelected;
          });
          allPrice += children[i]['price'] * children[i]['num'];
        }

        if (productList[index]['isSelected']) {
          setState(() {
            totalPrice += allPrice;
          });
        }

        isSelectAll = getSelectedStoreNumber() == productList.length;

        _computedProductNumber();
      },
      child: _buildCheckBox(isSelected),
    );
  }

  // 商品勾选
  _buildItemCheckBox(int index, int cIndex, Map item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          productList[index]['children'][cIndex]['isSelected'] =
              !item['isSelected'];
        });

        int selectedProductNumber = 0;
        List children = productList[index]['children'];

        for (var i = 0; i < children.length; i++) {
          if (children[i]['isSelected']) {
            ++selectedProductNumber;
          }
        }
        productList[index]['isSelected'] =
            selectedProductNumber == children.length;

        isSelectAll = getSelectedStoreNumber() == productList.length;

        bool isSelected = children[cIndex]['isSelected'];
        int price = children[cIndex]['price'] * children[cIndex]['num'];

        setState(() {
          isSelected ? totalPrice += price : totalPrice -= price;
        });

        _computedProductNumber();
      },
      child: Container(
        width: 30,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: _buildCheckBox(
          item['isSelected'],
        ),
      ),
    );
  }

  // 勾选元素
  _buildCheckBox(bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? Colors.red : Color(0xFFDDDDDD),
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFF93A19) : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Utils.iconFont(
          0xe736,
          isSelected ? Colors.white : Colors.transparent,
          13,
        ),
      ),
    );
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

  // 计算选中商品数量
  _computedProductNumber() {
    int count = 0;

    for (var i = 0; i < productList.length; i++) {
      var children = productList[i]['children'];

      for (var l = 0; l < children.length; l++) {
        if (children[l]['isSelected']) {
          ++count;
        }
      }
    }

    setState(() {
      selectedNumber = count;
    });
  }

  _buildItem(int index, int cIndex) {
    var item = productList[index]['children'][cIndex];

    return Container(
        child: Row(
      children: [
        _buildItemCheckBox(index, cIndex, item),
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
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.fromLTRB(5, 4, 5, 4),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Text(
                          '白色，128GB，官方标配，选服务',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '¥',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  item['price'].toString(),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '.00',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 20,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (item['num'] > 1) {
                                        setState(
                                          () {
                                            productList[index]['children']
                                                [cIndex]['num'] = --item['num'];
                                          },
                                        );
                                      } else {
                                        Utils.showText(text: '最少购买1件哦！');
                                      }
                                    },
                                    child: Container(
                                      width: 20,
                                      alignment: Alignment.center,
                                      child: Utils.iconFont(
                                          0xe715,
                                          item['num'] == 1
                                              ? Color(0xFF999999)
                                              : Color(0xFF333333),
                                          12),
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 20,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(
                                        3,
                                      ),
                                    ),
                                    child: Text(
                                      item['num'].toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          productList[index]['children'][cIndex]
                                              ['num'] = ++item['num'];
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 20,
                                      alignment: Alignment.center,
                                      child: Utils.iconFont(
                                        0xe716,
                                        Color(0xFF333333),
                                        12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
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
    ));
  }

  _buildSelectAll() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelectAll = !isSelectAll;
          });
          double price = 0;

          for (var i = 0; i < productList.length; i++) {
            var children = productList[i]['children'];

            setState(() {
              productList[i]['isSelected'] = isSelectAll;
            });

            for (var l = 0; l < children.length; l++) {
              setState(() {
                productList[i]['children'][l]['isSelected'] = isSelectAll;
              });
              var childrenItem = productList[i]['children'][l];
              price += childrenItem['price'] * childrenItem['num'];
            }

            setState(() {
              totalPrice = isSelectAll ? price : 0;
            });
          }

          _computedProductNumber();
        },
        child: _buildCheckBox(isSelectAll),
      ),
    );
  }

  _buildSettlement() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF9F9F9),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildSelectAll(),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Text('全选', style: TextStyle(fontSize: 12)),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  '合计:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  '¥${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 35,
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.only(left: 13, right: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFA2F19),
                      Color(0xFFFA722E),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  '去结算(${selectedNumber.toString()}）',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: TopBar(
        title: '购物车',
        titleStyle: TextStyle(color: Colors.black),
        backgroundColor: Color(0xFFF5F5F5),
      ),
      body: Container(
        color: Color(0xFFF5F5F5),
        child: Column(
          children: [
            Expanded(
                child: PullRefresh(
              refreshController: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView(
                // itemExtent: 150,
                children: List.generate(
                  productList.length,
                  (index) => Container(
                    margin: EdgeInsets.only(top: index == 0 ? 10 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              _buildTitleCheckBox(index),
                              Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Text(
                                  productList[index]['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            productList[index]['children'].length,
                            (cIndex) => Container(
                              height: 130,
                              color: Colors.white,
                              margin: EdgeInsets.only(bottom: 10),
                              child: Slidable(
                                key: Key(cIndex.toString()),
                                controller: slidableController,
                                actionPane: SlidableDrawerActionPane(),
                                showAllActionsThreshold: 1,
                                actionExtentRatio: 0.17,
                                fastThreshold: 1,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: _buildItem(index, cIndex),
                                ),
                                secondaryActions: List.generate(
                                  slideButtonList.length,
                                  (index) => SlideAction(
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: slideButtonList[index]
                                              ['color'],
                                        ),
                                      ),
                                      child: Text(
                                        slideButtonList[index]['name'],
                                        style: TextStyle(
                                          color: slideButtonList[index]
                                              ['textColor'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
            _buildSettlement()
          ],
        ),
      ),
    );
  }
}
