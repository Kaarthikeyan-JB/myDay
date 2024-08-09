import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:res/extensions/space_exs.dart';
import 'package:res/main.dart';
import 'package:res/utils/app_colors.dart';
import 'package:res/utils/app_strings.dart';
import 'package:res/utils/constants.dart';
import 'package:res/views/home/widget/task_appbar_view.dart';
import '../../../models/Task.dart';
import '../components/date_time_selection.dart';
import '../components/text_Field_Task.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.TaskTitleValue,
    required this.DescValue,
    required this.task
  });

  final TextEditingController? TaskTitleValue;
  final TextEditingController? DescValue;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    _titleController = widget.TaskTitleValue ?? TextEditingController();
    _descController = widget.DescValue ?? TextEditingController();
    //My fix
    if (widget.task != null) {
      _titleController.text = widget.task!.title ?? '';
      _descController.text = widget.task!.subtitle ?? '';
    }

  }

  @override
  void dispose() {
    if (widget.TaskTitleValue == null) {
      _titleController.dispose();
    }
    if (widget.DescValue == null) {
      _descController.dispose();
    }
    super.dispose();
  }

  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime).toString();
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  bool isTaskAlreadyExist() {
    if (widget.TaskTitleValue?.text == null &&
        widget.DescValue?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  dynamic isTaskAlreadyExistUpdateOtherWiseCreate() {
    // Update title and subtitle from the text controllers
    title = _titleController.text.trim();
    subTitle = _descController.text.trim();

    if (title.isNotEmpty && subTitle.isNotEmpty) {
      if (widget.task != null) {
        //Ensure date and time are set; otherwise, use the current date and time
        date ??= widget.task!.createdAtDate ?? DateTime.now();
        time ??= widget.task!.createdAtTime ?? DateTime.now();

        // Update the existing task
        widget.task!.title = title;
        widget.task!.subtitle = subTitle;
        widget.task!.createdAtDate = date!;
        widget.task!.createdAtTime = time!;
        widget.task!.save();
        Navigator.pop(context);
      } else {
        // Create a new task
        var task = Task.create(
          title: title,
          subtitle: subTitle,
          createdAtDate: date ?? DateTime.now(),
          createdAtTime: time ?? DateTime.now(),
        );
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      }
    } else {
      // Show a warning if fields are empty
      emptyWarning(context);
    }
  }



  //delete task
  dynamic deleteTask(){
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const TaskAppBarView(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryColor,
          ),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                topTaskTexts(textTheme),
                TaskViewActivity(textTheme, context),
                bottomButtons(),
                const SizedBox(
                  width: double.infinity,
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExist()
              ? Container()
              : MaterialButton(
            onPressed: () {
              deleteTask();
              Navigator.pop(context);
            },
            minWidth: 125,
            height: 55,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(
                  Icons.close,
                  color : Colors.deepOrange,
                ),
                5.w,
                const Text(
                  AppString.deleteTask,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdateOtherWiseCreate();
            },
            minWidth: 125,
            height: 55,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            color: Colors.red,
            child:  Text(
              isTaskAlreadyExist()
              ? AppString.addTaskString
              : AppString.updateTaskString,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget TaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              AppString.titleOfTitleTextField,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          TTextField(
            controller: _titleController,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),
          10.h,
          TTextField(
            controller: _descController,
            isForDesc: true,
            onFieldSubmitted: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
            onChanged: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
          ),
          DateTimeSelect(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    initDateTime: showDateAsDateTime(time),
                    onChange: (_, __) {},
                    dateFormat: 'HH:mm',
                    onConfirm: (dateTime, _) {
                      setState(() {
                        if (widget.task?.createdAtTime == null) {
                          time = dateTime;
                        } else {
                          widget.task!.createdAtTime = dateTime;
                        }
                      });
                    },
                  ),
                ),
              );
            },
            title: "TIME",
            time: showTime(time),
          ),
          DateTimeSelect(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                initialDateTime: showDateAsDateTime(date),
                onConfirm: (dateTime, _) {
                  setState(() {
                    if (widget.task?.createdAtDate == null) {
                      date = dateTime;
                    } else {
                      widget.task!.createdAtDate = dateTime;
                    }
                  });
                },
              );
            },

            title: "DATE",
            time: showDate(date),
          ),
        ],
      ),
    );
  }

  Widget topTaskTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              text: isTaskAlreadyExist()
                  ? AppString.addNewTask
                  : AppString.updateCurrentTask,
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: AppString.taskString,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}




