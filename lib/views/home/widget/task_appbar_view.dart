import 'package:flutter/material.dart';
import 'package:res/utils/app_colors.dart';

class TaskAppBarView extends StatelessWidget implements PreferredSizeWidget{
  const TaskAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryColor,
      ),
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left:20,),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(150);
}
