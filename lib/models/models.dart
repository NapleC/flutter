class BlogModel {
  String blogClass;
  String brief;
  String count;
  String createTime;
  String homeImg;
  String id;
  String name;
  String title;

  BlogModel({
    this.blogClass,
    this.brief,
    this.count,
    this.createTime,
    this.homeImg,
    this.id,
    this.name,
    this.title,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    this.blogClass = json["blog_class"];
    this.brief = json["brief"];
    this.count = json["count"];
    this.createTime = json["create_time"];
    this.homeImg = json["home_img"];
    this.id = json["id"];
    this.name = json["name"];
    this.title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["blog_class"] = this.blogClass;
    data["brief"] = this.brief;
    data["count"] = this.count;
    data["create_time"] = this.createTime;
    data["home_img"] = this.homeImg;
    data["id"] = this.id;
    data["name"] = this.name;
    data["title"] = this.title;
    return data;
  }
}
