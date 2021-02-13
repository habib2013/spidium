
import 'package:rxdart/rxdart.dart';
import 'package:spidium/models/blogposts_response.dart';
import 'package:spidium/repository/handleData.dart';

class BlogPostsBloc {
  final HandleData _repository = HandleData();
  final BehaviorSubject<BlogPostsResponse> _subject =
  BehaviorSubject<BlogPostsResponse>();

  getOtherBlogbloc() async {
    BlogPostsResponse response = await _repository.getOthersBlogRepo();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<BlogPostsResponse> get subject => _subject;

}

final blogPostsBloc = BlogPostsBloc();