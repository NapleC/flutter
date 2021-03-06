import 'package:flutter/material.dart';
import 'package:flutter_jd/utils/utils.dart';
import 'package:flutter_jd/widgets/layout/TabNavigator.dart';
import 'package:get/route_manager.dart';

// 登录
class Login extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<Login> {
  _buildText(String text) {
    return Text(
      text,
      style: TextStyle(color: Color(0xFF999999), fontSize: 12),
    );
  }

  _buildLinkText(String text, String page) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(page);
      },
      child: Text(
        text,
        style: TextStyle(color: Color(0xFF4a90e2), fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 45,
                height: 45,
                child: Utils.iconFont(0xe639, Color(0xFF666666), 22),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      child: Container(
                        width: 75,
                        height: 75,
                        margin: EdgeInsets.only(top: 80),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFEEEEEE),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(75),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Image.asset(
                            'assets/images/common/avatar.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        '181****0190',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFFA2F19),
                              Color(0xFFFA722E),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          splashColor: Color(0xFFFA2F19),
                          onTap: () {
                            Get.off(
                              () => TabNavigator(),
                              transition: Transition.noTransition,
                            );
                          },
                          child: Container(
                            width: 300,
                            height: 45,
                            alignment: Alignment.center,
                            child: Text(
                              '本机号码一键登录',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 12),
                      child: Text(
                        '其他方式登录',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF999999)),
                          borderRadius: BorderRadius.circular(12)),
                      child: Utils.iconFont(0xe736, Color(0xFF999999), 8),
                    ),
                    Container(
                        width: 290,
                        margin: EdgeInsets.only(left: 8),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            _buildText('使用手机号一键登录即代表您已同意'),
                            _buildLinkText('《隐私协议》', '/privacy'),
                            _buildText('和'),
                            _buildLinkText('《账号认证服务条款》', '/privacy'),
                            _buildText('并使用本手机号码登录'),
                          ],
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'XX账号为您提供本地号码登录服务',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
