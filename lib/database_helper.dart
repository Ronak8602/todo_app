import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task.dart';

class DatabaseHelper {
  final String dbName = "toDoAppDatabase";

  Future<Database> database() async {
    String path = join(await getDatabasesPath(), dbName);
    return openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
      );
    }, version: 1);
  }

  Future<void> insertTask(Task task) async {
    Database _db = await database();
    await _db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTask() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskList = await _db.query('tasks');
    return List.generate(taskList.length, (index) {
      return Task(
          id: taskList[index]['id'],
          title: taskList[index]['title'],
          description: taskList[index]['description']);
    });
  }
}
