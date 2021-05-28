import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_jd/utils/network_util.dart';
import 'package:flutter_jd/utils/utils.dart';
import 'package:flutter_jd/widgets/common/NetworkTips.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullRefresh extends StatefulWidget {
  final RefreshController refreshController;
  final Function onRefresh;
  final Function onLoading;
  final Widget child;
  final bool enablePullUp;
  final double headBottom;
  final bool enablePullDown;

  PullRefresh({
    Key key,
    this.refreshController,
    this.onRefresh,
    this.onLoading,
    this.child,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.headBottom = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<PullRefresh> {
  Widget _buildHeader() {
    return ClassicHeader(
      height: 150,
      outerBuilder: (child) => Column(
        children: <Widget>[
          Image.asset('assets/images/common/refresh.gif'),
          Container(
            margin: EdgeInsets.only(bottom: widget.headBottom),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: child,
            ),
          )
        ],
      ),
      idleText: '下拉刷新',
      idleIcon: Container(),
      releaseText: '松开刷新',
      releaseIcon: Container(),
      refreshingText: '刷新中',
      refreshingIcon: Container(),
      completeText: '刷新完成',
      completeIcon: Container(),
      completeDuration: Duration(milliseconds: 500),
      textStyle: TextStyle(
        color: Utils.hexToColor('#999999'),
        fontSize: 12,
      ),
    );
  }

  Widget _buildFooter() {
    return CustomFooter(
      height: 50,
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = _buildText("上拉加载");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = _buildText("加载失败 单击重试!");
        } else if (mode == LoadStatus.canLoading) {
          body = _buildText("松开加载更多");
        } else if (mode == LoadStatus.noMore) {
          body = _buildText("没有更多数据了");
        }
        return Container(
          height: 35,
          child: Center(child: body),
        );
      },
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Utils.hexToColor('#999999'),
        fontSize: 13,
      ),
    );
  }

  Widget _buildChild() {
    String networkStatus = NetworkUtil.networkStatus;

    if (networkStatus == 'noConnectNetwork') {
      return NetworkTips(tips: '似乎与互联网断开连接');
    } else if (networkStatus == 'overtime') {
      return NetworkTips(tips: '网络连接超时');
    } else {
      return widget.child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => WaterDropHeader(), // 配置默认头部指示器
      footerBuilder: () => ClassicFooter(), // 配置默认底部指示器
      headerTriggerDistance: 40.0, // 头部触发刷新的越界距离
      springDescription: SpringDescription(
        stiffness: 150,
        damping: 15,
        mass: 2,
      ), // 自定义回弹动画,三个属性值意义请查询flutter api
      maxOverScrollExtent: 1, //头部最大可以拖动的范围,
      maxUnderScrollExtent: 0, // 底部最大可以拖动的范围
      enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
      enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
      child: SmartRefresher(
        enablePullDown: widget.enablePullDown,
        enablePullUp: widget.enablePullUp,
        cacheExtent: 10,
        header: _buildHeader(),
        footer: _buildFooter(),
        controller: widget.refreshController,
        onRefresh: widget.onRefresh,
        onLoading: widget.onLoading,
        child: _buildChild(),
      ),
    );
  }
}
