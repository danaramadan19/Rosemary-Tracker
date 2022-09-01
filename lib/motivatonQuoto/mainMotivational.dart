import 'package:flutter/material.dart';
import 'package:untitled/motivatonQuoto/home.dart';

class mainMotivation extends StatefulWidget {
  const mainMotivation({ Key key }) : super(key: key);

  @override
  State<mainMotivation> createState() => _mainMotivationState();
}

class _mainMotivationState extends State<mainMotivation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: HomeMovtivationPage(),
        ),
    );
  }
}