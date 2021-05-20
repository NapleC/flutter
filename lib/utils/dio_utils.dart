import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/login/index.dart';
import 'package:flutter_jd/utils/config.dart';
import 'package:flutter_jd/utils/network_util.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_jd/utils/utils.dart';
import 'package:connectivity/connectivity.dart';

/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class DioUtils {
  static Dio dio;
  static const String API_PREFIX = Config.BASE_URL;
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 30000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  /*
   * url 请求链接
   * params 请求参数
   * metthod 请求方式
   * onSuccess 成功回调
   * onError 失败回调
   */
  static Future request<T>(String url,
      {context,
      params,
      method,
      Function(T t) onSuccess,
      Function(String error) onError}) async {
    params = params ?? {};
    method = method ?? 'GET';

    // 判断网络状态
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      NetworkUtil.networkStatus = 'noConnectNetwork';
      Utils.showText(
          text: '网络错误，请检查网络后重试', align: Alignment(0, 0.8), radius: 20);
    }

    if (connectivityResult != ConnectivityResult.none) {
      NetworkUtil.networkStatus = null;

      if (params is FormData) {
      } else {
        // 请求处理
        params.forEach((key, value) {
          if (url.indexOf(key) != -1) {
            url = url.replaceAll(':$key', value.toString());
          }
        });
      }

      if (Utils.isDebugMode()) {
        print('请求地址：【' + method + '  ' + url + '】');
        print('请求参数：' + params.toString());
      }

      Dio dio = createInstance();

      //请求结果
      var result;
      try {
        Response response = await dio.request(url,
            data: params, options: new Options(method: method));
        if (Utils.isDebugMode()) {
          // print(response.data.toString());
        }
        result = json.decode(response.data); //对数据进行Json转化

        if (result['code'] == 101) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => new Login()),
              (route) => route == null);
          return;
        }

        if (response.statusCode == 200) {
          if (onSuccess != null) {
            onSuccess(result);
          }
        } else {
          throw Exception('statusCode:${response.statusCode}');
        }

        if (Utils.isDebugMode()) {
          print('响应数据：' + response.toString());
        }
      } on DioError catch (e) {
        if (Utils.isDebugMode()) {
          print('请求出错：' + e.toString());
        }

        // 网络连接超时
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          NetworkUtil.networkStatus = 'overtime';
          Utils.showText(text: '网络连接超时', align: Alignment(0, 0.8), radius: 20);
        }

        onError(e.toString());
      }
      return result;
    }
  }

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      var options = BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        },
        baseUrl: API_PREFIX + '/collect/',
      );
      dio = new Dio(options);

      //拦截器
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        String token = await Utils.getToken();
        print(token);
        options.headers.addAll({"Authorization": "Bearer $token"});
        // print("开始请求");
        return options; //continue
      }, onResponse: (Response response) {
        // print("成功之前");
        return response; // continue
      }, onError: (DioError e) {
        // print("错误之前");
        return e; //continue
      }));
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}
