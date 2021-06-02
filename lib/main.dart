import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jd/pages/launch/index.dart';
import 'package:flutter_jd/routes/index.dart';
import 'package:flutter_jd/styles/app_theme.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// void main() {
//   runApp(App());

//   SystemChrome.setPreferredOrientations(
//     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 设备方向
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      title: '京东',
      getPages: AppPages.pages,
      home: LaunchPage(),
      builder: BotToastInit(),
      theme: AppTheme.defaultTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.native, // 默认过渡动画
      locale: Locale('zh', 'CH'),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}
