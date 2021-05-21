import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_jd/mock/mock.dart';
import 'package:flutter_jd/utils/utils.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';

class Category extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<Category> {
  int currentIndex = 0;
  List menuList = MENU_LIST;

  List productList = MENU_PRODUCT_LIST;

  _buildSearchBar() {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Utils.iconFont(0xe8b6, Color(0xFF999999), 19),
          ),
          Expanded(
            child: Container(
              height: 32,
              margin: EdgeInsets.only(left: 10, right: 10),
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
                            '机械键盘',
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

  _buildMenuList() {
    return Container(
      width: 110,
      color: Color(0xFFF6F6F6),
      child: ListView(
        children: List.generate(
          menuList.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: currentIndex == index ? Colors.white : Color(0xFFF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                menuList[index],
                style: TextStyle(
                  color:
                      currentIndex == index ? Colors.black : Color(0xFF666666),
                  fontSize: currentIndex == index ? 15 : 14,
                  fontWeight:
                      currentIndex == index ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildProductList() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: NotificationListener(
          // ignore: missing_return
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
              
            }
          },
          child: ListView(
            children: List.generate(
              productList.length,
              (index) => Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, bottom: 8),
                      child: Text(
                        productList[index]['title'],
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1 / 1.4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        productList[index]['children'].length,
                        (cIndex) => Container(
                          child: _buildProductListItem(
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
        ),
      ),
    );
  }

  _buildProductListItem(index, cIndex) {
    var item = productList[index]['children'][cIndex];

    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Image.asset(item['src']),
      ),
      Container(
        margin: EdgeInsets.only(top: 8),
        child: Text(
          item['name'],
          style: TextStyle(
            color: Color(0xFF666666),
            fontSize: 12,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        height: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          _buildSearchBar(),
          Expanded(
            child: Row(
              children: [_buildMenuList(), _buildProductList()],
            ),
          ),
        ],
      ),
    );
  }
}
