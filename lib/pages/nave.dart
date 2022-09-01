import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:untitled/appPages/chat.dart';
import 'package:untitled/appPages/post.dart';
import 'package:untitled/appPages/recomand.dart';
import 'package:untitled/appPages/tabbar.dart';
import 'package:untitled/appPages/taskpage.dart';
import 'package:untitled/ui/pages/home_page.dart';




class Curved extends StatefulWidget {
  const Curved({Key key}) : super(key: key);

  @override
  State<Curved> createState() => _CurvedState();
}

class _CurvedState extends State<Curved> {
  int _currentIndex = 0;
  void _changeItem(int value){
    print(value);
   setState(() {
     _currentIndex = value;
   });
  }

  List<Widget> _widgetOption = <Widget>[
     HomeToDoPage(),
      HomeLayout(),
    Recomand(),
    Posts(),
    Chat()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOption.elementAt(_currentIndex),
      bottomNavigationBar: Theme(
        data:Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.black)
        ),
      child:  CurvedNavigationBar(
        backgroundColor: Colors.transparent,

       color: Color(0xFFD4EABC),
        buttonBackgroundColor: Color(0xFF80C038),
        height: 60,
        animationCurve: Curves.easeInOut,
        items: [
          Icon(Icons.playlist_add_check),
          Icon(Icons.list),
          Icon(Icons.access_time),
          Icon(Icons.account_circle_outlined),
          Icon(Icons.favorite_border),
        ],

        onTap: _changeItem,
        index: _currentIndex ,
          //Handle button tap

      ),
      )
    );
  }
}
