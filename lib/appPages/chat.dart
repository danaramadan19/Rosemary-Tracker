import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/conponantapi/linkapi.dart';
import 'package:untitled/view/steps.dart';

import '../conponantapi/allCard.dart';
import '../conponantapi/curd.dart';



class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with Crud {
  getNotes() async {
    var response = await postRequest(linkViewAllPost, {});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
           Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
        }, icon: Icon(Icons.directions_walk))],
            
        title: Text("Share the stories of your sucsses" , style: TextStyle(fontSize: 20),),
       elevation: 0.0,
       backgroundColor: Colors.white,

       ),
      body: SingleChildScrollView(
          child: Column(

            children:[
             
               Padding(
                padding: EdgeInsets.all(10),
                child:  FutureBuilder(
                    future: getNotes(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data['status'] == 'faild')
                          return  Container(child: Center(child: Text("There is no Posts yet", style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: 'OpenSans',),)));
              
                        return ListView.builder(
                            itemCount: snapshot.data['data'].length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context , i){
              
                              return AllCard(
                                content: "${snapshot.data['data'][i]['notes_content']}",
              
                               );
              
              
              
              
                              },);
              
              
              
              
                      }if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: Text("loading"),);
                      }
                      return Center(child: Text("loading"),);
              
                    })
              
              
            ),
         ] )
    
    
    
      ),
    );
  }
}