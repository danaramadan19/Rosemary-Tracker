import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  //obs convert any obj from any type to stream  which is have alot of data so i have to
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task task}) {
    return DBHelper.insert(task);
  }

  //حلقة الوصل بين الفنكشن وقاعدة البيانات
  //get data from DB
  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

//delete data from db
  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

//update
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
