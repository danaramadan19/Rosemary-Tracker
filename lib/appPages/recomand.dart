import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/appPages/habitdetail.dart';
import 'package:untitled/conponantapi/curd.dart';
import 'package:untitled/conponantapi/linkapi.dart';

class Recomand extends StatefulWidget {
  const Recomand({Key key}) : super(key: key);

  @override
  State<Recomand> createState() => _RecomandState();
}

class _RecomandState extends State<Recomand> with Crud  {

   getHabit() async {
    var response = await postRequest(linkHabit, {});
    return response;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF6E3),
      appBar: AppBar(

         backgroundColor: Color(0xFFEDF6E3),
        elevation: 0.0,
        centerTitle: true,
      
        title: Text('Recommanded Habits',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68)
                )),
       
      ),

       body: ListView(
       padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
        
          SizedBox(height: 15.0),
         Row(
           children: [
             Text('Categories',
                  style: TextStyle(
                      fontSize: 42.0,
                      fontWeight: FontWeight.bold)),
                         SizedBox(width:100.0),

           ],
         ),
          SizedBox(height: 30.0),

                Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: FutureBuilder(
                future: getHabit(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data['status'] == 'faild')
                      return Center(child: Text("There is no Habits yet", style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: 'OpenSans',),));

                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                      //  physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context , i){

                          return _buildCard(
                          "${snapshot.data['data'][i]['name']}", "${snapshot.data['data'][i]['category']}", 'img/drink.png'
                             ,"${snapshot.data['data'][i]['description']}", "${snapshot.data['data'][i]['notes']}", context

                      

                           );




                          },);
                       }if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: Text("loading"),);
                  }
                  return Center(child: Text("loading"),);

                }),
       
    ),
    Container(height: 200,
    
    ),

    
    ]
    ),

    );
  }
}

Widget _buildCard(String name, String price, String imgPath, String description, String notes ,  context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CookieDetail(
                        assetPath: imgPath,
                    cookieprice:price,
                    cookiename: name,
                    cookienotes: notes,
                   )));
            },
            child: Container(
            
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                 
                    
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 250.0,
                          width: 250.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain)))),
                  SizedBox(height: 17.0),
                  Text(price,
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontFamily: 'Varela',
                          fontSize: 25.0)),
                  Text(name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 20.0)),

                          SizedBox(height: 20,),
              Center(
                child: Text(description , style: TextStyle(
                            color: Colors.black26,
                            fontFamily: 'Varela',
                            fontSize: 20.0)),
              ),
                ]))
                ));
  }

