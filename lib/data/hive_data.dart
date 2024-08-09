import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:res/models/Task.dart';


class HiveDataStore{

  static const boxName = 'TaskBox';
  final Box<Task> box = Hive.box<Task>(boxName);

  // Add task to the box
  Future<void> addTask({required Task task})async{
    await box.put(task.id, task);
  }

  // Show Task
  Future<Task?> getTask({required String id})async{
    return box.get(id);
  }

  //Update
  Future<void> updateTask({required Task task})async{
    await task.save();
  }

  //Delete
  Future<void> deleteTask({required Task task})async{
    await task.delete();
  }

  //Listen to Box Changes
  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}