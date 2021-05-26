import 'package:flutter/material.dart';
import 'package:flutter_jd/mock/mock.dart';
import 'package:flutter_jd/widgets/common/PullRefresh.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 发现
class Find extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<Find> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List productList = PRODUCT_LIST;

  _productList() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 7 / 8.9,
        ),
        physics: NeverScrollableScrollPhysics(),
        children: _buildProductList(),
      ),
    );
    // return Wrap(
    //   children: List.generate(10, (i) {
    //     return Container(
    //       color: Colors.primaries[i],
    //       height: 192,
    //       width: 192,
    //       child: Text('$i'),
    //     );
    //   }),
    // );
  }

  _buildProductList() {
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return list;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '发现',
      ),
      body: PullRefresh(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: _productList(),
      ),
    );
  }
}
