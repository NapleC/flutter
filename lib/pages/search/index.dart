import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/utils.dart';
import 'package:flutter_jd/widgets/layout/TopBar.dart';

class SearchPage extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<SearchPage> {
  List historyList = [
    'MacBook Pro',
    'iPhone12',
    '机械键盘',
    '手机',
    '笔记本电脑',
    '显示器',
    '洗发水',
    '吹风机',
    '水杯',
  ];

  Widget _buildHeader() {
    return Container(
      height: 50,
      color: Colors.white,
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 32,
              child: TextField(
                cursorColor: Color(0XFF097DFD),
                cursorHeight: 15,
                autofocus: true,
                autocorrect: true,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  fillColor: Color(0x30cccccc),
                  filled: true,
                  prefixIcon: Utils.iconFont(0xe692),
                  prefixIconConstraints: BoxConstraints(minWidth: 35),
                  suffixIcon: Utils.iconFont(0xe614),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x00FF0000)),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  hintText: '机械键盘',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x00000000)),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: Text('取消'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Expanded(
      child: SingleChildScrollView(
          child: GestureDetector(
        onPanDown: (_) {
          Utils.closeKeyboard(context);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(12, 5, 12, 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(12), left: Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        '搜索历史',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Utils.iconFont(0xe8b9)
                  ],
                ),
              ),
              Wrap(
                children: List.generate(
                  historyList.length,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 8, right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      historyList[index],
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        height: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [_buildHeader(), _buildContainer()],
        ),
      ),
    );
  }
}
