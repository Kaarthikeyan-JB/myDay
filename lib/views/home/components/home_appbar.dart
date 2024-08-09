import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:res/main.dart';
import 'package:res/utils/app_colors.dart';
import 'package:res/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatefulWidget{
  const HomeAppBar({super.key,required this.drawerKey});
  final GlobalKey<SliderDrawerState> drawerKey;
  @override
  State<HomeAppBar> createState() => HomeAppBarState();
}

class HomeAppBarState extends State<HomeAppBar> with SingleTickerProviderStateMixin{
  late AnimationController animateController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    animateController = AnimationController(vsync: this,
      duration: const Duration(seconds: 1)
    );
    super.initState();
  }

  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  ///On Toggle Slider mechanism
  void onDrawerToggle(){
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if(isDrawerOpen){
        animateController.forward();
        widget.drawerKey.currentState!.openSlider();
      }else{
        animateController.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context){
    var base = BaseWidget.of(context).dataStore.box;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryColor
      ),
      width: double.infinity,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Animation of menu icon
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: IconButton(onPressed: onDrawerToggle,
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: animateController,
                    size: 40,
                  )
              ),
            ),
            ///Trash Icon
            Text("myDay",style: GoogleFonts.pacifico(
              fontSize: 28
            )),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: IconButton(
                  onPressed: (){
                    ///Will Remove All Tasks
                    base.isEmpty
                    ? noTaskWarning(context)
                    : deleteAllTask(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.trash,
                    size: 38,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}