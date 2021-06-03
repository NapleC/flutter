import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/api/blogApi.dart';
import 'package:flutter_jd/models/models.dart';
import 'package:flutter_jd/widgets/common/PullRefresh.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 博客
class Blog extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<Blog> {
  // 博客列表
  List<BlogModel> blogList = [];
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 加载数据
  void loadData() async {
    BlogApi.getBlogList().then((list) {
      setState(() {
        blogList = list;
        // blogList.addAll(list);
      });
    });
  }

  // 下拉刷新
  _onRefresh() async {
    _refreshController.loadComplete();
    loadData();

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
      backgroundColor: Color(0xFFF5F5F5),
      appBar: TopBar(
        title: '博客',
        isBack: true,
      ),
      body: PullRefresh(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: blogList.length,
          itemExtent: 130,
          itemBuilder: (BuildContext context, int index) {
            BlogModel model = blogList[index];

            return Container(
              margin: EdgeInsets.only(top: 8),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/blog_detail', arguments: {'id': model.id});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  model.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 1, top: 5),
                                  child: Text(
                                    model.brief,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 1),
                                        child: Text(
                                          '${model.createTime} 发布',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 15, top: 1),
                                        child: Text(
                                          '${model.count} 阅读',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 11,
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
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Container(
                            width: 120,
                            height: 80,
                            color: Color(0xFFF2F2F2),
                            child: Image.network(
                              model.homeImg,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
