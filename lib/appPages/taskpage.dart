import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/archived_tasks/archived_tasks_screen.dart';
import 'package:untitled/cubid/cubit.dart';
import 'package:untitled/cubid/states.dart';
import 'package:untitled/done_tasks/done_tasks_screen.dart';
import 'package:untitled/motivatonQuoto/mainMotivational.dart';
import 'package:untitled/new_tasks/new_tasks_screen.dart';
import 'package:untitled/timer/screens/main_screen.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/component.dart';
import 'package:untitled/view/home_page.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDBState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            body: cubit.screens[cubit.currentIndex],
            appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => mainMotivation()),
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
                title: Text(cubit.titles[cubit.currentIndex]),
                backgroundColor: Colors.white),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(titleController.text,
                        timeController.text, dateController.text);
                    // insertToDatabase(titleController.text, timeController.text,
                    //         dateController.text)
                    //     .then((value) {
                    //   getDatafromDatabase(database).then((value) {
                    //     Navigator.pop(context);

                    //     //       setState(() {
                    //     //          isBottomSheetShown = false;
                    //     //         fabIcon = Icons.edit;
                    //     //          tasks = value;
                    //     //           print(tasks);
                    //     //  });
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                                      hintText:
                                          'What do you wanna do for this day?',
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
                                      hintText:
                                          'On which date do you wanna do it?',
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
                    cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                  });

                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0.0,
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index) {
                // setState(() {
                //   currentIndex = index;
                // });
                AppCubit.get(context).changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'ToDo'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}
