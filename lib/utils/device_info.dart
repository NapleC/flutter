/*
    * @description:  获取设备信息
    * @return {type} 设备信息
    */
import 'dart:io';

import 'package:device_info/device_info.dart';

Future<dynamic> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
  var dataInfo;
  if (Platform.isIOS) {
    print('IOS设备：');
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    dataInfo = iosInfo;
  } else if (Platform.isAndroid) {
    print('Android设备');
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    
    dataInfo = androidInfo;
  }
  return dataInfo;
}

//  获取设备的指定信息
class FlutterDeviceInfo {
  // 获取设备的唯一标识 uuid
  static Future<String> get platformUid async {
    var data = await getDeviceInfo(), res;
    if (Platform.isIOS) {
      res = data.identifierForVendor;
    } else if (Platform.isAndroid) {
      res = data.id;
    }
    return res;
  }

  //  获取设备name
  static Future<String> get platformName async {
    var data = await getDeviceInfo(), res;
    if (Platform.isIOS) {
      res = data.name;
    } else if (Platform.isAndroid) {
      res = data.device;
    }
    return res;
  }

  // 获取设备的model
  static Future<String> get platformModel async {
    var data = await getDeviceInfo();
    return data.model;
  }
}
