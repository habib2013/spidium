import 'package:dio/dio.dart';
import 'package:spidium/models/blogposts_response.dart';


class HandleData {
  static String mainUrl = 'http://192.168.137.1:5003';
  final Dio _dio = Dio();

  var getOthersBlog = '$mainUrl/blogpost/getOtherBlog';

  Future<BlogPostsResponse> getOthersBlogRepo() async {
    // try{
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im9sYWRvc3UiLCJpYXQiOjE2MTEwNTE1Nzd9.bbbyAzt5YWvEt6UT0dHFHyWF3tfJ5RUIYyKSu730lx8';
      Response response = await _dio.get(getOthersBlog);
      print(response.data);
      return BlogPostsResponse.fromJson(response.data);

    // }
    // catch(error,stacktrace) {
    //   print("Exception occured: $error stacktrace: $stacktrace");
    //   return BlogPostsResponse.withError(error);
    // }
  }


}