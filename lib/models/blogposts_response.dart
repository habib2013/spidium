
import 'package:spidium/models/blogposts.dart';

class BlogPostsResponse {
  final List<BlogModel> blog;
  final String error;

  BlogPostsResponse(this.blog,this.error);

  BlogPostsResponse.fromJson(Map<String,dynamic> json)
      : blog = (json["blog"] as List).map((i) => new BlogModel.fromJson(i)).toList(),
        error = "";

  BlogPostsResponse.withError(String errorValue)
      : blog = List(),
        error = errorValue;
}