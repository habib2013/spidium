
import 'package:http/http.dart';
import 'package:spidium/models/blogposts_response.dart';

import 'auth_provider.dart';


class Repository {
  static String mainUrl = "http://192.168.137.1:5003";
  // final String apiKey = "814c2572e4ee4517a676a3cafead582d";



  final AuthProvider authProvider = AuthProvider();

  Future<Response> login(String url,Map <String,String> data) => authProvider.post(url,data);
  Future<Response> register(String url,Map <String,String> data) => authProvider.post(url,data);
  // Future<Response> getOthersBlog(String url) => authProvider.get(url);

  // Future<BlogPostsResponse> getOthersBlog() async {
  //     var url = 'blogpost/getOtherBlog';
  //
  //   try{
  //     // Response response = await _dio.get(getSourceUrl,queryParameters: params);
  //       Response response = authProvider.get(url) as Response;
  //     return BlogPostsResponse.fromJson(response);
  //
  //   }
  //   catch(error,stacktrace) {
  //     print("Exception occured: $error stacktrace: $stacktrace");
  //     // return SourceResponse.withError(error);
  //   }
  // }


}