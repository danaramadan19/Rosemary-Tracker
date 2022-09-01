import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/conponantapi/curd.dart';
import 'package:untitled/conponantapi/linkapi.dart';
import 'package:untitled/conponantapi/valid.dart';
import 'package:untitled/main.dart';

import '../ui/widgets/custemTextForm.dart';

class EditPosts extends StatefulWidget {
  final notes;
  const EditPosts({Key key, this.notes}) : super(key: key);

  @override
  State<EditPosts> createState() => _EditPostsState();
}

class _EditPostsState extends State<EditPosts> with Crud{
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController content = TextEditingController();

  bool isLoading = false;

  editPosts() async{
    if(formstate.currentState.validate()){
      isLoading = true;
      setState(() {

      });
      var response = await postRequest(linkEditPost, {
        "content" : content.text,
        "id" : widget.notes['notes_id'].toString(),

      });
      isLoading = false;
      setState(() {

      });
      if(response['status'] == "success"){
        Navigator.of(context).pushReplacementNamed("home");
      }
    }
  }
  @override
  void initState() {
content.text = widget.notes['notes_content'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Post"),),
      body: isLoading == true?
      Center(child: CircularProgressIndicator(),)
          :Container(

        padding: EdgeInsets.all(10),

        child: Form(
          key: formstate,
          child: ListView(children: [
            CustomTextFormSign(myController: content, hint: 'content', valid: (val) {
              
              return validInput(val, 20, 10000);
            },),
            Container(height: 20,),
            MaterialButton(onPressed: ()async{
              await editPosts();
            },
              child: Text("Save"),
              textColor: Colors.white,
              color: Colors.lightGreen,
            )
          ],),
        ),
      ),
    );
  }
}
