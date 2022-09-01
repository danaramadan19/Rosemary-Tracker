import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/archived_tasks/archived_tasks_screen.dart';
import 'package:untitled/done_tasks/done_tasks_screen.dart';
import 'package:untitled/motivatonQuoto/mainMotivational.dart';
import 'package:untitled/new_tasks/new_tasks_screen.dart';
import 'package:untitled/timer/screens/main_screen.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/component.dart';
import 'package:untitled/view/home_page.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

 

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        key: scaffoldKey,
        appBar: AppBar(
          actions: [
               IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => mainMotivation()),
                );
              },
              icon: const Icon(
                Icons.format_quote,
                size: 24,
                color: primaryClr,
              )),
        
              IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: const Icon(
                Icons.note_add,
                size: 24,
                color: primaryClr,
              )),

                    IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              icon: const Icon(
                Icons.center_focus_strong,
                size: 24,
                color: primaryClr,
              )),
          ],
          backgroundColor: Colors.white,
          title: const Text('ToDo List'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Tasks",
                icon: Icon(Icons.menu),
              ),
              Tab(
                text: "Done",
                icon: Icon(Icons.check_circle_outline),
              ),
              Tab(
                text: "Archive",
                icon: Icon(Icons.archive_outlined),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            if (isBottomSheetShown) {
              if (formKey.currentState.validate()) {
                insertToDatabase(titleController.text, timeController.text,
                        dateController.text)
                    .then((value) {
                       getDatafromDatabase(database).then((value) {
          
            
                  Navigator.pop(context);
                 
                  setState(() {
                     isBottomSheetShown = false;
                    fabIcon = Icons.edit;
                     tasks = value;
                      print(tasks);
             });
        });


                });
              }
            } else {
              scaffoldKey.currentState
                  .showBottomSheet(
                    (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          TextFormField(
                            controller: titleController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'title must not be empty';
                              }
                              if (value.isAPKFileName) {
                                return 'you are a hacker!what a piece of shit';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.title),
                              hintText: 'What do you wanna do for this day?',
                              labelText: 'ToDo title',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: timeController,
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                timeController.text =
                                    value.format(context).toString();
                                print(value.format(context));
                              });
                            },
                            keyboardType: TextInputType.datetime,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'time must not be empty';
                              }
                              if (value.isAPKFileName) {
                                return 'you are a hacker!what a piece of shit';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.watch_later_outlined),
                              hintText: 'When do you wanna do it?',
                              labelText: 'ToDo time',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: dateController,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              ).then((value) {
                                dateController.text =
                                    DateFormat.yMMMd().format(value);
                              });
                            },
                            keyboardType: TextInputType.datetime,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'date must not be empty';
                              }
                              if (value.isAPKFileName) {
                                return 'you are a hacker!what a piece of shit';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              hintText: 'On which date do you wanna do it?',
                              labelText: 'ToDo Date',
                            ),
                          ),
                        ]),
                      ),
                    ),
                    elevation: 20.0,
                  )
                  .closed
                  .then((value) {
                isBottomSheetShown = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              });

              isBottomSheetShown = true;
              setState(() {
                fabIcon = Icons.add;
              });
            }
          },
          child: Icon(fabIcon),
        ),
        body: TabBarView(
          children: <Widget>[
            NewTasksScreen(),
            DoneTasksScreen(),
            ArchivedTasksScreen(),
          ],
        ),
     
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');

        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT , time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table');
        });
      },
      onOpen: (database) {
        getDatafromDatabase(database).then((value) {
          setState(() {
            
       
          tasks = value;
          print(tasks);
             });
        });
      },
    );
  }

  Future insertToDatabase(@required String title, @required String time,
      @required String date) async {
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('inserted success $value');
      }).catchError((error) {
        print('errore insert ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDatafromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
