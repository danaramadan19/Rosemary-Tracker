import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:untitled/ui/widgets/colors.dart';

class AllCard extends StatelessWidget {
  //final String name;
  final String content;

  const AllCard({Key key,  this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
 
  ),
        child: Column(
          children: [
            ExpandablePanel(
              header: Text('Dana', style: TextStyle(fontSize: 15, ),),
              collapsed: Text('$content' , style: TextStyle(fontSize: 20 , ), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Text('$content' , style: TextStyle(fontSize: 20 , ), softWrap: true, ),
             // tapHeaderToExpand: true,
             // hasIcon: true,
             theme: const ExpandableThemeData(crossFadePoint: 0,
             iconColor: Colors.lightGreen,
             tapHeaderToExpand: true,
             hasIcon: true,
             
             ),
            ),
            Row(children:[IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined)),
          
            ] ),
          
          ],
        ),
      ),
    );
    
    
    // Padding(
    //   padding: const EdgeInsets.only(bottom: 20.0),
    //   child: Container(
    //     width: double.infinity,
    //     height: 150.0,

    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(25.0),

    //         color: Colors.white,
    //         border: Border.all(
    //           color: Colors.black12,
    //           width: 1,
    //         )
    //     ),

    //   child: Column(
    //             children: <Widget>[
    //               Container(
    //                 height: 50,
    //                 color: Colors.grey[200],
    //                  child: Row(children: [
    //                      SizedBox(width: 5,),
    //                    CircleAvatar(
                       
    //                      backgroundColor: Colors.lightGreen,
    //                      radius: 20,
    //                    ),
    //                    SizedBox(width: 10,),
    //                     Text('Dana', style: TextStyle(fontSize: 15, ),)
    //                     ],),
    //               ),
    //               //   Container(

    //               //   width: double.infinity,
    //               //   height: 200,
    //               //   decoration: BoxDecoration(
    //               //       borderRadius: BorderRadius.circular(25.0),
    //               //       image: DecorationImage(image: AssetImage('img/todo.png'),
    //               //         fit: BoxFit.fitWidth,
    //               //       )
    //               //   ),
    //               // ),
    //                SizedBox(width: 10,),
                      
    //                   Text('$content' , style: TextStyle(fontSize: 20 , ))
                  


    //             ],

    //           ),



    //   ),
    // );

  }

}
