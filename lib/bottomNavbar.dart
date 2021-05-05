import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/favstab/fav_tab.dart';
import 'package:news_feed/newstab/news_tab.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: WillPopScope(
        onWillPop: () async {
          if (index == 0) return true;
          setState(() {
            index = 0;
          });
          return false;

/* below code keeps track of all the navigated indexes*/
          if (_navigationQueue.isEmpty) return true;

          setState(() {
            index = _navigationQueue.last;
            _navigationQueue.removeLast();
          });
          return false;
        },
        child: Scaffold(
          body: (_getBody(index)),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,

            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: index,

            // onTap: (value) => setState(() => index = value),
            onTap: (value) {
              _navigationQueue.addLast(index);
              setState(() => index = value);
              print(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    height: 60.0,
                    color: index == 0 ? Colors.blueAccent : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_sharp,
                            size: 34,
                            color: index == 0 ? Colors.white : Colors.black),
                        SizedBox(width: 13),
                        Text(
                          "News",
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? Colors.white : Colors.black),
                        )
                      ],
                    ),
                  ),

                  // ignore: deprecated_member_use
                  title: Padding(padding: EdgeInsets.all(0))),
              BottomNavigationBarItem(
                  icon: Container(
                    height: 60.0,
                    color: index == 1 ? Colors.blueAccent : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite,
                            size: 34,
                            color: index == 1 ? Colors.white : Colors.red),
                        SizedBox(width: 13),
                        Text(
                          "Favs",
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: index == 1 ? Colors.white : Colors.black),
                        )
                      ],
                    ),
                  ),
                  title: Padding(padding: EdgeInsets.all(0))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return NewsTab();
      case 1:
        return FavTab();
    }
  }
}
