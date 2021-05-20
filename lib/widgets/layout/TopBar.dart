import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/utils.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  final String title;
  final List<Widget> actions;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final String backImgName;
  final bool isBack;
  final Brightness brightness;
  final double height;
  TopBar(
      {this.bottom,
      this.title,
      this.actions,
      this.titleStyle,
      this.backgroundColor,
      this.backImgName,
      this.isBack: false,
      this.brightness,
      this.height: 45});
  @override
  _TopBarState createState() => _TopBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(this.bottom != null ? 91 : this.height);
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, // 标题居中
      brightness: widget.brightness,
      leading: GestureDetector(
        onTap: () {
          if (widget.isBack) {
            Navigator.pop(context);
          }
        },
        child: Opacity(
          opacity: widget.isBack ? 1 : 0,
          child: Container(
            width: 30,
            color: Colors.transparent,
            padding: EdgeInsets.only(right: 10),
            child: Utils.iconFont(0xe671, Color(0xFF333333), 18),
          ),
        ),
      ),
      title: new Text(
        widget.title ?? '',
        style: TextStyle(
          color: Color(0xFF333333),
          fontSize: 17,
        ),
        // style: widget.titleStyle ?? new TextStyle(
        //   color: Color(0xFF333333),
        //   fontSize: 17.0,
        // ),
      ),
      backgroundColor: widget.backgroundColor ?? Color(0xFFFFFFFF),
      elevation: 0,
      bottom: widget.bottom,
      actions: widget.actions,
    );
  }
}

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  AppBarBottom({
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xFFE5E5E5),
          ),
          child ??
              SizedBox(
                height: 0,
              ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(this.child != null ? 47 : 1);
}
