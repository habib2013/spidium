import 'package:flutter/material.dart';
import 'package:dashed_circle/dashed_circle.dart';


class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with SingleTickerProviderStateMixin{
  Animation gap;
  Animation base;
  Animation reverse;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 104));
    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
        child: Column(
          children: [
            showUserStory(),
            SizedBox(height: 20,),
            showTrendingCards(),
            SizedBox(height: 20,),
            showSpecialTrend(),

          ],
        ),

    );
  }

 Widget showUserStory() {
    return Container(
      height: 90,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 9,
          scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 80,

              alignment: Alignment.center,
              child: RotationTransition(
                turns: base,
                child: DashedCircle(
                  gapSize: gap.value,
                  dashes: 10,
                  color: Color(0XFFED4634),
                  child: RotationTransition(
                    turns: reverse,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),

                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1564564295391-7f24f26f568b"
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );



 }

  Widget showTrendingCards() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending',
              style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),

          ],
        ),
        SizedBox(height: 30,),

        Column(
         children: [
           Row(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/walpa.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.blue.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('Technology',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 18,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/gaming.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.black.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('Gaming',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 19,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/news.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.blue.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('News',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 20,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
             ],
           ),
           SizedBox(height: 10,),
           Row(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/music.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.blue.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('Music',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 20,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/culture.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.black.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('Culture',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 19,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/adventss.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.blue.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('Adventure',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 20,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
             ],
           ),
           SizedBox(height: 10,),
           Row(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/health.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.blue.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('Health',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 20,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/politics.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.black.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('Politics',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 19,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width * 0.31,
                 child: Card(
                   elevation: 4,
                   child: Container(
                     width: 80,
                     height: 80,
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.all(Radius.circular(6)),
                         image: DecorationImage(
                           image: AssetImage('assets/images/eins.jpg'),
                           fit: BoxFit.cover,
                           colorFilter: new ColorFilter.mode(
                               Colors.blue.withOpacity(0.73),
                               BlendMode.dstATop),
                         )),
                     child: Center(child: Text('Geeks',style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 20,fontWeight: FontWeight.bold),)),
                   ),
                 ),
               ),
             ],
           ),
         ],

        )

      ],
    );
  }

  Widget showSpecialTrend() {
    return Column(
      children: [

      ],
    );
  }
}
