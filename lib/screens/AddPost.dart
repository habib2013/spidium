import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AddPostsScreen extends StatefulWidget {
  @override
  _AddPostsScreenState createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  TextEditingController _blogtitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add a new Post',
                    style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 80,
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
                              Colors.white12,
                              Colors.white,
                            ])),
                    child: Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Josefin Sans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _ourInputsForm("Backgound Image & Title", _blogtitle),
          ],
        ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.13,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),)
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text('Item $index'));
                  },
                ),
              );
            },
          ),

        ],
      )
    );
  }

  Widget _ourInputsForm(String title, var ourController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 11),
      child: TextFormField(
        controller: ourController,
        validator: (value) {},
        decoration: InputDecoration(
          prefixIcon: Icon(FeatherIcons.image),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            errorStyle: TextStyle(color: Colors.red),
            hintText: title,
          ),

      ),
    );
  }
}
