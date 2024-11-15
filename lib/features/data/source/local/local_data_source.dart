import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_remote_sample_data_app/core/exception/exceptions.dart';
import 'package:local_remote_sample_data_app/features/data/model/todo_model.dart';

const dataBox = 'myBox';

abstract interface class LocalDataSource {
  Future<List<TodoModel>> getAllData();
  Future<void> saveTodo(List<TodoModel> todo);
}

class LocalDataSourceImpl implements LocalDataSource {
  Future<void> _openDB() async {
    await Hive.openBox<TodoModel>(dataBox);
  }

  @override
  Future<List<TodoModel>> getAllData() async {
    try {
      await _openDB();
      final todosBox = Hive.box<TodoModel>(dataBox);
      return todosBox.values.toList();
    } catch (e) {
      throw DatabaseException(
          message: "Database error occured can't get todos");
    }
  }

  @override
  Future<void> saveTodo(List<TodoModel> todo) async {
    try {
      if (!Hive.isBoxOpen(dataBox)) {
        await _openDB();
      }
      final todosBox = Hive.box<TodoModel>(dataBox);
      await todosBox.clear();
      await todosBox.addAll(todo);
    } catch (e) {
      throw DatabaseException(
          message: "Database error occurred can't save data");
    }
  }
}
