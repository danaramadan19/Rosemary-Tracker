import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/controllers/note_controller.dart';
import 'package:untitled/ui/widgets/alarm_dialog.dart';
import 'package:untitled/ui/widgets/searchbar.dart';

import 'add_new_note_page.dart';
import 'note_detail_page.dart';


class HomePage extends StatelessWidget {
  final controller = Get.put(NoteController());

  Widget emptyNotes() {
    return Container(
       color: Color(0xFFEDF6E3),
      child: Column(
      //  mainAxisAlignment: MainAxisAlignment.center,
      //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               _addTaskBar(),
            SizedBox(height: 200,),
                  Center(
                    child: SvgPicture.asset(
                        'img/add.svg',
                        height: 150,
                        semanticsLabel: 'Task',
                      ),
                  ),
            SizedBox(height: 20,),
            Center(
              child: Text(
                "Start writing your journal and Enjoy!",style: TextStyle(
                fontSize: 20, color: Colors.grey
              ),
              ),
            ),
          ],

      ),
    );
  }

  Widget viewNotes() {
    return Scrollbar(
      child: Container(

        color: Color(0xFFEDF6E3),
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child:StaggeredGridView.countBuilder(
          
            itemCount: controller.notes.length,
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 20.0,


            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  //todo go to other page with index
                  Get.to(
                    NoteDetailPage(),
                    arguments: index,
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialogWidget(
                        contentText: "Are you sure you want to delete this Journal?",
                        confirmFunction: () {
                          controller.deleteNote(controller.notes[index].id);
                          Get.back();
                        },
                        declineFunction: () {
                          Get.back();
                        },
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    ///////////////////////////////
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //todo add note(title) from index
                        controller.notes[index].title,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        //todo add note(content) from index
                        controller.notes[index].content,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        maxLines: 6,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
             
                        controller.notes[index].dateTimeEdited,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        brightness: Brightness.light,
elevation: 0.0,

        title: Text(
          "Journal",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFEDF6E3),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          ),
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      contentText: "Are you sure you want to delete all your Journal?",
                      confirmFunction: () {
                        controller.deleteAllNotes();
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete All Journals",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => controller.isEmpty() ? emptyNotes() : viewNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>AddNewNotePage());
        },
        child: Icon(
          Icons.add,
        ),
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
       
        ],
      ),
    );
  }
}
