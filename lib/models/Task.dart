import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'Task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
});

  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subtitle;
  @HiveField(3)
  DateTime createdAtTime;
  @HiveField(4)
  DateTime createdAtDate;
  @HiveField(5)
  bool isCompleted;


  //create new task
  factory Task.create({
    required String? title,
    required String? subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
    }) =>
      Task(
          id: const Uuid().v1(),
          title: title??"",
          subtitle: subtitle??"",
          createdAtTime: createdAtTime??DateTime.now(),
          createdAtDate: createdAtDate??DateTime.now(),
          isCompleted: false,
      );
}