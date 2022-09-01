import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/ui/widgets/button.dart';

class Diary extends StatefulWidget {
  const Diary({ Key key }) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
           elevation: 0,
        backgroundColor: Colors.white,
        title:  Text("Journal Page", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600 , ),),

     ),
      body: Column(
        children: [
        

          _addTaskBar(),
         
          const SizedBox(
            height: 6,
          ),
     
        ],
      ),
      
    );
  }

   _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Today',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          MyButton(
              lable: 'Your Diary',
              onTap: ()  {
              
              }),
        ],
      ),
    );
  }
}