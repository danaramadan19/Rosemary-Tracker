// ignore_for_file: prefer_single_quotes

import 'package:analog_clock/analog_clock.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/conponantapi/curd.dart';
import 'package:untitled/conponantapi/edit.dart';
import 'package:untitled/main.dart';
import 'package:untitled/model/notemodel.dart';
import 'package:untitled/ui/widgets/colors.dart';

import '../conponantapi/linkapi.dart';
import '../conponantapi/post.dart';

class Posts extends StatefulWidget {

  const Posts({Key key}) : super(key: key);

  @override
  State<Posts> createState() => _PostState();
}

class _PostState extends State<Posts> with Crud{
    String username;
   String number;

  getNotes() async {
    var response = await postRequest(linkViewNotes, {
      "id" : sharedPref.getString("id")
    });
    return response;
  }

  getName() async {
    var response = await postRequest(linknamePost, {
      "id" : sharedPref.getString("id")
    });
    return response;
  }

    getCount() async {
    var response = await postRequest(linkcountPost, {
      "id" : sharedPref.getString("id")
    });
    return response;
  }


  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.7,
            child: Container(
              //////////////////////////
              color: Colors.lightGreen,
       child:  Center(
            child: AnalogClock(
              decoration: BoxDecoration(
                  border: Border.all(width: 3.0, color: Colors.black),
                  color: Colors.black,
                  shape: BoxShape.circle),
              width: 200.0,
              isLive: true,
              hourHandColor: Colors.white,
              minuteHandColor: Colors.white,
              secondHandColor: Colors.lightGreen,
              showSecondHand: true,
              numberColor: Colors.white,
              showNumbers: true,
              textScaleFactor: 1.5,
              showTicks: true,
              showDigitalClock: true,
              digitalClockColor: Colors.white,
              datetime: DateTime(2030, 8, 4, 9, 11, 0),
            ),
             ),
          
            ),
          ),

          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.3,
            child: Container(
              color: Colors.white,
            ),
          ),

          ////sliding panel
          SlidingUpPanel(
            controller: _panelController,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(32), topLeft: Radius.circular(32)),
            minHeight: MediaQuery.of(context).size.height * 0.35,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            body: GestureDetector(
              onTap: () => _panelController.close(),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            panelBuilder: (ScrollController controller) =>
                _panelBody(controller),
          )
        ],
      ),
    );
  }

  ///panel body
  SingleChildScrollView _panelBody(ScrollController controller) {
    double hPadding = 40;
    return SingleChildScrollView(
      controller: controller,
      physics: ClampingScrollPhysics(),
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FutureBuilder(
                  future: getName(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){

                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context , i){

                            return _titleSection(username: "${snapshot.data['data'][i]['username']}");
                          });


                    }if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: Text("loading"),);
                    }
                    return Center(child: Text("loading"),);

                  }),

                       FutureBuilder(
                  future: getCount(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){

                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context , i){

                            return _infoCell(number: "${snapshot.data['data'][i]['COUNT(`notes_users`)'].toString()}", title: "POSTS Number:");
                          });


                    }if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: Text("loading"),);
                    }
                    return Center(child: Text("loading"),);

                  }),

             // _infoSection(),
              _buttonSection(),
            ],
          ),
        ),

        // const Divider(
        //   height: 5,
        //   thickness: 1,
        //   indent: 0,
        //   endIndent: 0,
        //   color: Color(0xFFC4C3C3FF),
        // ),

        Padding(
            padding: EdgeInsets.all(10),
            child:  FutureBuilder(
                future: getNotes(),
                
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                   if(snapshot.data['status'] == 'faild')
                     return Center(child: Text("You have not posted any post", style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold , fontFamily: 'OpenSans',),));

                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context , i){

                          return PostCard(
                           
                              content: "${snapshot.data['data'][i]['notes_content']}",
                            onpressed: () {Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditPosts(notes:snapshot.data['data'][i],))
                            );

                            }, onDelete: ()  {
                            AwesomeDialog(context: context,
                              dialogType: DialogType.ERROR,
                              btnOkOnPress: () async {
                               var response  = await postRequest(linkDeletePost, {
                               "id" : snapshot.data['data'][i]['notes_id'].toString()
                           });
                           if(response['status'] == "success"){
                             Navigator.of(context).pushReplacementNamed("home");
                           }
                              },
                              btnCancelOnPress: () {},
                              body: const Text("Are you sure you want to Delete it?"),
                            ).show();


                          },  );

                        });


                  }if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: Text("loading"),);
                  }
                  return Center(child: Text("loading"),);

                })


        )
      ]),
    );
  }

  Row _buttonSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      
        Expanded(
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed("addpost");
            },
            color: Colors.lightGreen,
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text(
              'ADD POST',
              style: TextStyle(
                fontFamily: 'NimbusSanL',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        )
      ],
    );
  }

  //info section
  
  Row _infoSection() {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //posts number from db
        _infoCell(title: 'POSTS number:', number:  "$number"),
        //vertical line
       
    
      ],
    );
  }

  Row _infoCell({ String title ,  String number} ) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),

       SizedBox(width: 10),
        //change # of posts from DB
        Text(
        number ,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

//Title Section
  Column _titleSection({username}) {
    return Column(
      children: <Widget>[
        //name from DB

        Text(
          "$username",
          style: TextStyle(
            fontFamily: 'NimbusSanL',
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
