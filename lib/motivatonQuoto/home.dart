import 'package:flutter/material.dart';
import 'package:untitled/motivatonQuoto/favorite_quotes.dart';
import 'package:untitled/motivatonQuoto/quote_data.dart';

class HomeMovtivationPage extends StatelessWidget {
  const HomeMovtivationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: size.width / 5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Quote of the day',
          style: TextStyle(fontFamily: 'quoteScript', fontSize: 22.0 ,  color: Colors.black,),
        ),
        bottom: TabBar(
          tabs: <Widget>[
            Tooltip(
              message: 'Daily Quotes',
              child: Tab(
                icon: Icon(
                  Icons.today,
                  color: Colors.black,
                ),
              ),
            ),
            Tab(
              icon: Icon(Icons.favorite,
               color: Colors.black,),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Stack(children: <Widget>[
            Center(
              child: Image.asset(
                'images/background.jpg',
                width: size.width,
                height: size.height,
                fit: BoxFit.fill,
              ),
            ),
            QuoteData(),
          ]),
          FavoriteQuotes(),
        ],
      ),
    );
  }
}