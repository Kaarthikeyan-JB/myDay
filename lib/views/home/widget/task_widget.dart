import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:res/views/home/widget/task_view.dart';
import '../../../models/Task.dart';


class TaskWidget extends StatefulWidget {
  const TaskWidget({
    Key? key, required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForSubTitle = TextEditingController();

  @override
  void initState() {
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForSubTitle.text = widget.task.subtitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(
            builder: (ctx)=>TaskView(
              TaskTitleValue: textEditingControllerForTitle,
              DescValue: textEditingControllerForSubTitle,
              task: widget.task,
            )
        ));
      },
      child: AnimatedContainer(
        //height: 200,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          ///Colours for task tile
            borderRadius: BorderRadius.circular(8),
            color: widget.task.isCompleted
            ? Colors.red
            : Colors.orangeAccent.shade400,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(.1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ]
        ),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          ///Check Icon
          leading: GestureDetector(
            onTap: (){
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                  color:
                  widget.task.isCompleted
                  ? Colors.red:
                  Colors.white,
                  shape: BoxShape.circle,
                  border:
                  Border.all(color: Colors.grey,width: .8)
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),),),
          ///Task Name
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5,top: 3),
            child: Text(
              textEditingControllerForTitle.text,
              style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              decoration: widget.task.isCompleted
                  ? TextDecoration.lineThrough : null,
            ),
            ),
          ),
          ///Task Description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textEditingControllerForSubTitle.text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough : null,
                ),
              ),

              ///Date of Task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10,top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),
                        style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),),

                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: const TextStyle(
                        fontSize: 12,
                          color: Colors.black,
                      ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}