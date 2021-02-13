class BlogModel {
  final String username;
  final String title;
  final String body;
  final String readTime;
  final String datePublished;
  final String category;
  final String coverImage;
  final int comment;




  BlogModel(this.username,this.title,this.body,this.readTime,this.datePublished,this.category,this.comment,this.coverImage);

  BlogModel.fromJson(Map<String,dynamic> json)
      : username = json["username"],
        title = json["title"],
        readTime = json["readTime"],
        body = json["body"],
        datePublished = json["datePublished"],
        category = json["category"],
        coverImage = json["coverImage"],
        comment = json["comment"];

}