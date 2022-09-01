import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/mood/screens/start.dart';
import 'package:untitled/ui/pages/notification_screen.dart';
import 'package:untitled/ui/size_config.dart';
import 'package:untitled/ui/theme.dart';
import 'package:untitled/ui/widgets/alarm_dialog.dart';
import 'package:untitled/ui/widgets/button.dart';
import 'package:untitled/ui/widgets/cponfitanimation.dart';
import 'package:untitled/ui/widgets/input_field.dart';
import 'package:intl/intl.dart';
import 'package:untitled/ui/widgets/task_tile.dart';
import 'package:untitled/view/home_page.dart';

import '../../controllers/task_controller.dart';
import '../../main.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import 'add_task_page.dart';

class HomeToDoPage extends StatefulWidget {
  const HomeToDoPage({Key key}) : super(key: key);

  @override
  State<HomeToDoPage> createState() => _HomeToDoPageState();
}

class _HomeToDoPageState extends State<HomeToDoPage> {
  NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    _taskController.getTasks();
  }

  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: const Icon(
                Icons.exit_to_app,
                size: 24,
                color: primaryClr,
              )),
          const SizedBox(
            width: 230,
          ),
          IconButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StartPage()),
                );
              },
              icon: const Icon(
                Icons.face_retouching_natural,
                size: 24,
                color: primaryClr,
              )),
         
          IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.WARNING,
                  btnOkOnPress: () {
                    notifyHelper.cancelAllNotification();
                    _taskController.deleteAllTasks();
                  },
                  btnCancelOnPress: () {},
                  body: Text("Delete all of your Habits?"),
                )..show();
              },
              icon: Icon(
                Icons.cleaning_services_outlined,
                size: 24,
                color: primaryClr,
              )),
        ],
      ),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(
            height: 6,
          ),
          _showTasks(),
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
              lable: '+Add Habit',
              onTap: () async {
                await Get.to(() => const AddTaskPage());
                _taskController.getTasks();
              }),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    _taskController.getTasks();
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemBuilder: (BuildContext, int index) {
                var task = _taskController.taskList[index];

                if (task.date == DateFormat.yMd().format(_selectedDate) ||
                    task.repeat == 'Daily' ||
                    (task.repeat == 'Weekly' &&
                        _selectedDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date))
                                    .inDays %
                                7 ==
                            0) ||
//اذا تطابق اليوم فقط يكفيني
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date).day ==
                            _selectedDate.day)) {
                  // var hour = task.startTime.toString().split(':')[0];
                  // var minutes = task.startTime.toString().split(':')[1];

                  // debugPrint('My time is' + hour);
                  // debugPrint('My minute is' + minutes);

                  var date = DateFormat.jm().parse(task.startTime);
                  var myTime = DateFormat('HH:mm').format(date);

                  notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[1]),
                    task,
                  );
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () => showBottomSheet(context, task),
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: _taskController.taskList.length,
            ),
          );
        }
      }),
    );
  }

  _noTaskMsg() {
    //الستاك بسمح بترتيب العناصر فوق بعضها
    return Stack(
      children: [
        AnimatedPositioned(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: SizeConfig.orientation == Orientation.landscape
                      ? Axis.horizontal
                      : Axis.vertical,
                  children: [
                    SizeConfig.orientation == Orientation.landscape
                        ? const SizedBox(
                            height: 120,
                          )
                        : const SizedBox(
                            height: 180,
                          ),
                    SvgPicture.asset(
                      'img/add.svg',
                      height: 150,
                      semanticsLabel: 'Habit',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        'you dont have any Habit yet \n click on Add Habit button to create your \n new Habit and make a routin',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            duration: const Duration(milliseconds: 2000))
      ],
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          //if the task is completed or not we will reduce the height for the 3 choises complete delete cancle
          // width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.30
                  : SizeConfig.screenHeight * 0.39),
          color: Colors.white,

          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      label: 'Habit Done',
                      onTap: () {
      
                      
                  
                          notifyHelper.cancelNotification(task);
                            _taskController.markTaskCompleted(task.id);
                      
        
                        Get.back();
                      },
                      clr: primaryClr),
              _buildBottomSheet(
                  label: 'Delete Habit ',
                  onTap: () {
                    notifyHelper.cancelNotification(task);
                    _taskController.deleteTasks(task);

                    Get.back();
                  },
                  clr: Colors.red[300]),
              Divider(
                color: Colors.grey,
              ),
              _buildBottomSheet(
                  label: 'Cancel',
                  onTap: () {
                    Get.back();
                  },
                  clr: primaryClr),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomSheet(
      {@required String label,
      @required Function() onTap,
      @required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose ? Colors.grey[300] : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(label,
                style: GoogleFonts.oldenburg(
                  textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ))),
      ),
    );
  }
}
