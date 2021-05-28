import 'package:flutter/material.dart';
import 'package:flutter_jd/widgets/common/UnderlineIndicator.dart';

class TabBarCustom extends StatelessWidget {
  final List tabs;
  final EdgeInsets indicatorInsets;
  final TabController tabController;

  TabBarCustom({
    Key key,
    @required this.tabs,
    this.indicatorInsets = const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
          isScrollable: true,
          indicator: UnderlineIndicator(
            insets: indicatorInsets,
            borderSide: BorderSide(
              width: 2.5,
              color: Colors.red,
            ),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Color(0xFF555555),
          labelColor: Color(0xFF222222),
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          tabs: tabs
              .map(
                (text) => Container(
                  child: Tab(text: text),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
