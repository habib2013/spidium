import 'dart:async';

import 'package:flutter/material.dart';

enum NavBarItem {HOME,EXPLORE,ADD_BLOG,BOOKMARK,PROFILE}

class BottomNavBloc {
  final StreamController<NavBarItem> _navBarController =
  StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch(i) {
      case 0:
        _navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.EXPLORE);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.ADD_BLOG);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.BOOKMARK);
        break;
      case 4:
        _navBarController.sink.add(NavBarItem.PROFILE);
        break;
    }
  }

  close(){
    _navBarController.close();
  }
}