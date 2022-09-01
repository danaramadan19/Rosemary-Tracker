import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:untitled/controllers/task_controller.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/button.dart';

import '../../models/task.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedRemind = 5;
  List<int> remindList = [0,5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

    String _selectedCategory = 'None';
  List<String> categoryList = ['None', 'Health', 'Wealth', 'Education','Enjoyment'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(

      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
               /* Text('Add Habit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Raleway')),*/
                InputField(
                  title: 'Title',
                  hint: 'Enter title here',
                  controller: _titleController,
                ),
                InputField(
                  title: 'Note',
                  hint: 'Enter note here',
                  controller: _noteController,
                ),
                Row(
                  children:[
                    
                    Expanded(
                    child: InputField(
                      title: 'Date',
                      hint: DateFormat.yMd().format(_selectedDate),
                      widget: IconButton(
                          onPressed: () => _getDateFromUser(),
                          icon: const Icon(Icons.calendar_today_outlined,
                              color: Colors.grey)),
                    ),

                  ),
                   const SizedBox(
                      width: 6,
                    ),

                    Expanded(
                      
                     child:  InputField(
                    title: 'Category',
                    hint: 'None',
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(10),
                           items: categoryList
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )))
                              .toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          underline: Container(
                            height: 0,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'Raleway'),
                          onChanged: (String newValue) {
                            setState(() {
                              _selectedRemind = int.parse(newValue);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 6,
                        )
                      ],
                    )),
                    )
               ] ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                            onPressed: () =>
                                _getTimeFromUser(isStartTime: true),
                            icon: const Icon(Icons.access_time,
                                color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(
                            onPressed: () =>
                                _getTimeFromUser(isStartTime: false),
                            icon: const Icon(Icons.access_time,
                                color: Colors.grey)),
                      ),
                    )
                  ],
                ),
                InputField(
                    title: 'Remind',
                    hint: '$_selectedRemind minutes early',
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(10),
                          items: remindList
                              .map<DropdownMenuItem<String>>(
                                  (int value) => DropdownMenuItem<String>(
                                      value: value.toString(),
                                      child: Text(
                                        '$value',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )))
                              .toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          underline: Container(
                            height: 0,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'Raleway'),
                          onChanged: (String newValue) {
                            setState(() {
                              _selectedRemind = int.parse(newValue);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 6,
                        )
                      ],
                    )),
                InputField(
                    title: 'Repeat',
                    hint: _selectedRepeat,
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(10),
                          items: repeatList
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )))
                              .toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          underline: Container(
                            height: 0,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: 'Raleway'),
                          onChanged: (String newValue) {
                            setState(() {
                              _selectedRepeat = newValue;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 6,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPalette(),
                    MyButton(
                        lable: 'Create Habit',
                        onTap: () {
                          _validateDate();
                        }),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  AppBar _appBar() {
    return AppBar(
  centerTitle: true,
      title: Text('Add Habit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Raleway')),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: primaryClr,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        //pic if you want lec 10 to know how
      ],
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasksToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required', 'All fields are requided!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } else
      print('there is a problem');
  }

  _addTasksToDb() async {
    //الفاليو يلي رح يرجع هو الاي دي
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0, //مبدا~يا لازم يكون صفر
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      ),
    );
    print('$value');
  }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color'),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                  radius: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (_pickedDate != null)
      setState(() => _selectedDate = _pickedDate);
    else
      print('its null wrong');
  }

  _getTimeFromUser({@required bool isStartTime}) async {
    TimeOfDay _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String _formattedTime = _pickedTime.format(context);
    if (isStartTime) {
      setState(() => _startTime = _formattedTime);
    }
 else if (!isStartTime) {
      setState(() => _endTime = _formattedTime);
    } else {
      print('cancle');
    }
    
  }
}
