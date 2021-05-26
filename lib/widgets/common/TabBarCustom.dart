import 'package:flutter/material.dart';
import 'package:flutter_jd/widgets/common/UnderlineIndicator.dart';

class TabBarCustom extends StatelessWidget {
  final List tabs;
  final EdgeInsets indicatorInsets;
  final TabController tabController;

  TabBarCustom({
    Key key,
    @required this.tabs,
    this.indicatorInsets = const EdgeInsets.fromLTRB(16, 0, 16, 0),
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        child: TabBar(
          controller: tabController,
          indicator: UnderlineIndicator(insets: indicatorInsets),
          // indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.red,

          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          tabs: tabs.map((text) => Tab(text: text)).toList(),
        ),
      ),
    );
  }
}
