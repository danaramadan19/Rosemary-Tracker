import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/conponantapi/edit.dart';
import 'package:untitled/conponantapi/linkapi.dart';
import 'package:untitled/model/notemodel.dart';

class PostCard extends StatelessWidget {
  //final String name;
  final String username;
  final String content;
  final void Function() onpressed;
  final void Function() onDelete;
  final NoteModel notemodel;
  const PostCard(
      {Key key,
       this.content,
       this.onpressed,
       this.username,
       this.onDelete, this.notemodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
   
      
        child: Container(
padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
 
     
      
   
  ),
          child: ExpandablePanel(
          header: Container(child: Row(children: [
                               Text("Dana" ,  style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold )),
                                SizedBox(width: 130,),

                                IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                tooltip: "Delete",
                                iconSize: 30,
                                onPressed: onDelete,
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: onpressed,
                              ),
                           ],),
                        
                           ),
          collapsed: Text('$content' , style: TextStyle(fontSize:20 , ), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          expanded: Text('$content' , style: TextStyle(fontSize: 20 , ), softWrap: true, ),
       // tapHeaderToExpand: true,
       // hasIcon: true,
       theme: const ExpandableThemeData(crossFadePoint: 0,
       iconColor: Colors.lightGreen,
       tapHeaderToExpand: true,
       hasIcon: true,
       useInkWell: true
       
       ),
      ),
        ),
        
        
        
        
        
        
        
        
        
      //   Column(
      //     children: <Widget>[
      //       Column(
      //         children: <Widget>[
      //           Container(
      //             width: double.infinity,
      //             height: 200,
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(25),
      //                 image: DecorationImage(
      //                   image: AssetImage("images/profile.jpg") ,
      //                   fit: BoxFit.fill,
      //                 )),
      //           ),
      //           Column(
      //             children: [
      //                   Text('$content' , style: TextStyle(fontSize: 15 , ),),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: <Widget>[
                    
                        
      //                       IconButton(
      //                         icon: Icon(Icons.delete),
      //                         color: Colors.red,
      //                         tooltip: "Delete",
      //                         iconSize: 30,
      //                         onPressed: onDelete,
      //                       ),
      //                       IconButton(
      //                         icon: Icon(Icons.edit),
      //                         onPressed: onpressed,
      //                       ),
                         
      //                 ],
      //               ),
                
      //             ],
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
  
    );
  }
}
