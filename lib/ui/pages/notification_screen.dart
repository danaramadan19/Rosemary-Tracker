import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/conponantapi/curd.dart';
import 'package:untitled/conponantapi/linkapi.dart';
import 'package:untitled/main.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key, @required this.payload}) : super(key: key);

  final String payload;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with Crud {
  String username;
  String _payload = '';

  getName() async {
    var response = await postRequest(linknamePost, {
      "id" : sharedPref.getString("id")
    });
    return response;
  }


  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
       // backgroundColor: context.theme.backgroundColor,
        title: Text(
          _payload.toString().split('|')[0],
          style: TextStyle(color:darkGreyClr),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
               FutureBuilder(
                  future: getName(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){

                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context , i){
                           return Text("${snapshot.data['data'][i]['username']}") ;
                          });
                              }if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: Text("loading"),);
                    }
                    return Center(child: Text("loading"),);

                  }),

                       const SizedBox(height: 10),
                       Text(",You have a new Reminder")

              
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,  vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryClr,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.text_format,
                              size: 30, color: Colors.white),
                          SizedBox(width: 20),
                          Text(
                            'Title',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _payload.toString().split('|')[0],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Icon(Icons.description,
                              size: 30, color: Colors.white),
                          SizedBox(width: 20),
                          Text(
                            'Description',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _payload.toString().split('|')[1],
                        style:
                        const TextStyle(color: Colors.white, fontSize: 20),
                     textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Icon(Icons.calendar_today_outlined,
                              size: 30, color: Colors.white),
                          SizedBox(width: 20),
                          Text(
                            'Date',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _payload.toString().split('|')[2],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
