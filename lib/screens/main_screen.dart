import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:showcaseview/showcase.dart';
import 'package:spidium/bloc/bottom_nav_bloc.dart';
import 'package:spidium/screens/explore_screen.dart';
import 'package:spidium/screens/AddPost.dart';
import 'package:spidium/tabs/Tab_Home_Screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final Shader linearGradient = LinearGradient(
    colors: <Color>[  Colors.blueAccent,
      Colors.red[300],],
  ).createShader(Rect.fromLTWH(0.0, 10.0, 200.0, 70.0));

  BottomNavBloc _bottomNavBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavBloc = BottomNavBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            decoration: BoxDecoration(
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(FeatherIcons.trello,color: Colors.purple,size: 26,),
                SizedBox(width: 6,),
                // Text(
                //   'Home',
                //   style: TextStyle(fontFamily: 'Josefin Sans', color: Colors.purple,fontWeight: FontWeight.w900,fontSize: 20,letterSpacing: 1.4),
                // ),
                Text(
                  'SPIDIUM',
                  style: new TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient),
                )
              ],
            ),
          ),
          centerTitle: false,

          iconTheme: new IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              icon: Icon(
                FeatherIcons.search,
                color: Colors.purple,
              ),
              onPressed: (){
                showSearch(context: context,delegate: ArticleSearch());
              },
            ),
            IconButton(
              icon: Icon(
                FeatherIcons.bell,
                color: Colors.purple,
              ),
              onPressed: null,
            ),
          ],
        ),
      ),
      body: SafeArea(child: StreamBuilder<NavBarItem>(
        stream: _bottomNavBloc.itemStream,
        initialData: _bottomNavBloc.defaultItem,
        builder: (BuildContext context,AsyncSnapshot<NavBarItem> snapshot) {
          switch(snapshot.data) {
            case NavBarItem.HOME:
              return TabHomeScreen();
            case NavBarItem.EXPLORE:
              return ExploreScreen();
            case NavBarItem.ADD_BLOG:
              return AddPostsScreen();
            case NavBarItem.BOOKMARK:
              return TestScreen();
            case NavBarItem.PROFILE:
              return TestScreen();
          }
        },
      )

      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBloc.itemStream,
        initialData: _bottomNavBloc.defaultItem,
        builder: (BuildContext context,AsyncSnapshot<NavBarItem> snapshot){
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[100],spreadRadius: 0,blurRadius: 10.0
                  )
                ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20.0,
                unselectedItemColor: Colors.blueGrey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                selectedItemColor: Colors.purple,
                type: BottomNavigationBarType.fixed,
                // fixedColor: Color.fromRGBO(3, 9, 23, 1),
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                      title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Home",),
                      ),
                      icon: Icon(FeatherIcons.home),
                      activeIcon: Icon(FeatherIcons.home,)
                  ),
                  BottomNavigationBarItem(
                      title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Explore",),
                      ),
                      icon: Icon(FeatherIcons.airplay),
                      activeIcon: Icon(FeatherIcons.airplay)
                  ),
                  BottomNavigationBarItem(
                      title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Post",),
                      ),
                      icon: Icon(FeatherIcons.plusCircle,size: 30,),
                      activeIcon: Icon(FeatherIcons.plusCircle,size: 30,)
                  ),
                  BottomNavigationBarItem(
                      title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Bookmark",),
                      ),
                      icon: Icon(FeatherIcons.bookmark),
                      activeIcon: Icon(FeatherIcons.bookmark)
                  ),
                  BottomNavigationBarItem(
                      title: Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text("Profile"),
                      ),
                      icon: Icon(FeatherIcons.user),
                      activeIcon: Icon(FeatherIcons.user)
                  ),
                ],
              ),

            ),
          );
        },

      ),
    );
  }

  Widget TestScreen(){
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Test Screen"),
        ],
      ),
    );
  }
}

class ArticleSearch extends SearchDelegate<String>{
    final articles = [
      "Artificial Intelligence",
      "Problem Solving",
      "Flutter","React",
      "Start up",
      "100 daysOfCoding",
      "Javascript",
      "IDEs",
      "Google",
      "Automobile",
      "Tesla",
      "Facebook"
    ];

    final recentArticles = [
      "Artificial Intelligence",
      "Problem Solving",
      "Flutter","React",
      "Start up",
    ];


    @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear),onPressed: (){
            query = '';
      },)
    ];
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
      );

    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {

      return Card(

      );
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      final suggestionList = query.isEmpty ? recentArticles : articles.where((p) => p.startsWith(query)).toList();
      return ListView.builder(
        itemBuilder: (context,index) =>
          ListTile(
            onTap: (){
              showResults(context);
            },
            leading: Icon(FeatherIcons.cast),
            title: RichText(text: TextSpan(
              text: suggestionList[index].substring(0,query.length),
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Raleway'),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey,fontFamily: 'Raleway'),
                )
              ]
            ),)
          ),
        itemCount: suggestionList.length,
      );
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
  
}