import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/utils.dart';

class NetworkTips extends StatefulWidget {
  final String tips;
  NetworkTips({Key key, this.tips}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyState();
}

class MyState extends State<NetworkTips> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/avatar.png', width: 100),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(bottom: 100),
            child: Text(
              widget.tips,
              style: TextStyle(
                color: Utils.hexToColor('#999999'),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
