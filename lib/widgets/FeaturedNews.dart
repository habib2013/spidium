import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spidium/bloc/Blogposts_bloc.dart';
import 'package:spidium/models/blogposts.dart';
import 'package:spidium/models/blogposts_response.dart';

class FeaturedNews extends StatefulWidget {
  @override
  _FeaturedNewsState createState() => _FeaturedNewsState();
}

class _FeaturedNewsState extends State<FeaturedNews> {

  @override
  void initState() {
    // TODO: implement initState
      blogPostsBloc.getOtherBlogbloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured',
                  style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 130,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.blueAccent,
                            Colors.red[300],
                          ])),
                  child: Text(
                    'See All >',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 270,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, position) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(1, 3, 10, 10),
                    child: Card(
                        elevation: 0.4,
                        child: Column(
                          children: [
                            Container(
                              width: 170,
                              height: 130,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/rrrr.jpeg'),
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                        Colors.blue.withOpacity(0.9),
                                        BlendMode.dstATop),
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Community',
                                style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('What will happen to \n communities after \nignoring  the talents ?',style: TextStyle(fontFamily: 'Josefin Sans',fontSize: 13),maxLines: 3,overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 15,),

                            Container(
                              height: 25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(FeatherIcons.heart,size: 16,),
                                      SizedBox(width: 10,),
                                      Text('158',style: TextStyle(fontFamily: 'Josefin Sans',fontSize: 13,color: Colors.black),)
                                    ],
                                  ),
                                  SizedBox(width: 14,),
                                  Row(
                                    children: [
                                      Icon(Icons.comment,size: 16,),
                                      SizedBox(width: 10,),
                                      Text('119',style: TextStyle(fontFamily: 'Josefin Sans',fontSize: 13,color: Colors.black),)
                                    ],
                                  ),
                                ],
                              ),
                            )

                          ],
                        )
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25,),

            StreamBuilder<BlogPostsResponse>(
              stream: blogPostsBloc.subject.stream,
              builder: (context, AsyncSnapshot<BlogPostsResponse> snapshot){
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return Container();
                  }
                  return _buildEditorsScreen(snapshot.data);
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  return buildLoaderWidget();
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Technology',
                  style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 130,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.blueAccent,
                            Colors.red[300],
                          ])),
                  child: Text(
                    'See All >',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context,index){
                return technologyList();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEditorsScreen(BlogPostsResponse data){
    List<BlogModel> blogPosts = data.blog;
     
    if (blogPosts.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No  Blog",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    }
    else {
      return Container(
      //  height: 500,

        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context,index){
            String realcoverImage = blogPosts[index].coverImage;
            print(realcoverImage);
            String cutUploadAway = realcoverImage.substring(8);
            return GestureDetector(
              onTap: (){},
              child:     Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    margin: const EdgeInsets.only(bottom: 10,top: 10),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(6)),
                        // image: DecorationImage(
                        //   image: AssetImage('assets/images/wwww.jpeg'),
                        //   fit: BoxFit.cover,
                        //   colorFilter: new ColorFilter.mode(
                        //       Colors.blue.withOpacity(0.9),
                        //       BlendMode.dstATop),
                        // )
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network('http://192.168.137.1:5003/uploads/' + cutUploadAway,
                        fit: BoxFit.cover,
                      ),
                    ),
                                    ),
                  Positioned(
                    top: 13.0,
                    right: 2.0,

                    child: IconButton(
                      icon: Icon(FeatherIcons.moreVertical,color: Colors.white,size: 24,),
                     onPressed: (){print('Hello');},

                    ),
                  ),
                  Positioned(
                    bottom: 8.0,
                    left: 8.0,
                    right: 8.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(blogPosts[index].body,
                          style:const TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Raleway',fontSize: 22
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10,),
                        // Text(' Research - William Candar',textAlign: TextAlign.center,
                        //   style:const TextStyle(
                        //       color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Josefin Sans',fontSize: 22
                        //   ),
                        //   maxLines: 3,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    left: 15.0,
                    right: 8.0,
                    child: Text(blogPosts[index].title,
                      style:const TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Raleway',fontSize: 24
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
  Widget buildLoaderWidget(){
    return Container(
      child: Column(
        children: [
          CupertinoActivityIndicator()
        ],
      ),
    );
  }

  Widget technologyList() {
    return Card(

      elevation: 0.2,
      child: ListTile(
        leading: Container(
            // width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
            height: 70,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset('assets/images/rrrr.jpeg',fit: BoxFit.cover,)
            )
        ),
        title: Text('12-April-2021 \n',style: TextStyle(fontSize: 14,color: Colors.black45,fontFamily: 'Raleway'),),
        subtitle: Text('Hello googg and this is rhe only and this is rhe only',maxLines: 2,style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: 'Josefin Sans'),),

      ),
    );
  }
}
