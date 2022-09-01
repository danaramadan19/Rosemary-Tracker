import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/conponantapi/curd.dart';
import 'package:untitled/conponantapi/linkapi.dart';
import 'package:untitled/conponantapi/valid.dart';
import 'package:untitled/main.dart';

import '../ui/widgets/custemTextForm.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({Key key}) : super(key: key);

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> with Crud {
  File myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController content = TextEditingController();

  bool isLoading = false;

  addPosts() async {
    // if (myfile == null) {
    //   return AwesomeDialog(context: context, title: "important" , body: Text("please add image To make your story more inspiring")).show();
    // }

    if (formstate.currentState.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestwithFile(linkAddPost,
          {"content": content.text, "id": sharedPref.getString("id")}, myfile);
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustomTextFormSign(
                      myController: content,
                      hint: 'content',
                      valid: (val) {
                        return validInput(val, 20, 10000);
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            XFile xfile = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                                          Navigator.of(context).pop();
                                            myfile = File(xfile.path);
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            child: Row(children: [
                                              Icon(Icons.browse_gallery),
                                              Text(
                                                "From Gallery",
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ]),
                                          )),
                                      InkWell(
                                        onTap: () async {
                                          XFile xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          Navigator.of(context).pop();
                                          myfile = File(xfile.path);
                                          setState(() {});
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            child: Row(children: [
                                              Icon(Icons.camera_alt),
                                              Text(
                                                "From Camera",
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ])),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: Text("Choose Image"),
                      textColor: Colors.white,
                      color: myfile == null ? Colors.lightGreen : Colors.green,
                    ),
                    Container(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await addPosts();
                      },
                      child: Text("Add"),
                      textColor: Colors.white,
                      color: Colors.lightGreen,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
