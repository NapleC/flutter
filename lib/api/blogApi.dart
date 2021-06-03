import 'package:flutter_jd/models/models.dart';
import 'package:flutter_jd/utils/dio_utils.dart';

// 博客 Api
class BlogApi {
  // 获取博客列表
  static Future<List<BlogModel>> getBlogList() async {
    final res = await DioUtils.request("/api/getBlogList");

    List<BlogModel> blogList = [];

    for (var blog in res['data']) {
      blogList.add(BlogModel.fromJson(blog));
    }

    return blogList;
  }
}
