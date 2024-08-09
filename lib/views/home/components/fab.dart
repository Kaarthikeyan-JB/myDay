import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:res/utils/app_colors.dart';
import 'package:res/views/home/widget/task_view.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => const TaskView(
                  TaskTitleValue: null,
                  DescValue: null,
                  task: null,
                ),
            )
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            gradient: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}