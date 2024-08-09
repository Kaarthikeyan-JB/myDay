import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:res/extensions/space_exs.dart';
import 'package:res/main.dart';
import 'package:res/utils/app_strings.dart';
import 'package:res/utils/constants.dart';
import 'package:res/views/home/components/fab.dart';
import 'package:res/views/home/components/home_appbar.dart';
import 'package:res/views/home/widget/task_widget.dart';
import 'package:animate_do/animate_do.dart';
import '../../models/Task.dart';
import 'components/slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  //check value of progress
  dynamic valueOfIndicator(List<Task> task){
    if(task.isNotEmpty){
      return task.length;
    }else{
      return 3;
    }
  }
  int checkDoneTask(List<Task> tasks){
    int i=0;
    for(Task doneTask in tasks){
      if(doneTask.isCompleted){
        i++;
      }
    }
    return i;
  }


  @override
  Widget build(BuildContext context) {

    TextTheme texttheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx,Box<Task> box,Widget? child){
          var tasks = box.values.toList();
          tasks.sort((a,b) => a.createdAtDate.compareTo(b.createdAtDate));

          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: const Fab(),
            body: SliderDrawer(
              key: drawerKey,
              isDraggable: false,
              animationDuration: 1000,
              ///Side bar
              slider: CustomSlider(),

              appBar: HomeAppBar(
                drawerKey: drawerKey,
              ),
              ///main body
              child: buildHomeBody(
                  texttheme: texttheme,
                base: base,
                tasks: tasks,

              ),
            ),
          );
        }
    );
  }
}

class buildHomeBody extends StatelessWidget {
  const buildHomeBody({
    super.key,
    required this.texttheme,
    required this.base,
    required this.tasks,
  });

  final TextTheme texttheme;
  final BaseWidget base;
  final List<Task> tasks;

  //check value of progress
  dynamic valueOfIndicator(List<Task> task){
    if(task.isNotEmpty){
      return task.length;
    }else{
      return 3;
    }
  }
  int checkDoneTask(List<Task> tasks){
    int i=0;
    for(Task doneTask in tasks){
      if(doneTask.isCompleted){
        i++;
      }
    }
    return i;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          ///Manual App Bar
          Container(
            margin: const EdgeInsets.only(top: 27),
            width: double.infinity,
            height: 100,
            ///color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ///Progress Indicator
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: checkDoneTask(tasks)/valueOfIndicator(tasks),
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation(
                        Colors.deepOrange),
                  ),
                ),
                25.w,
                ///Top Level task info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.mainTitle,
                      style: texttheme.displayLarge,
                    ),
                    3.h,
                    Text(
                      "${checkDoneTask(tasks)} of ${tasks.length} Task",
                      style: texttheme.titleMedium,
                    ),

                  ],
                ),
              ],
            ),
          ),
          ///Divider
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Divider(
              thickness: 2,indent: 100,
            ),
          ),
          ///Tasks
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 643,
              child: tasks.isNotEmpty
                  ?ListView.builder(
                itemCount: tasks.length,
                scrollDirection: Axis.vertical,
                  itemBuilder: (context, index){
                  //get single task for showing on list
                  var task = tasks[index];
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    onDismissed: (_){
                      base.dataStore.deleteTask(task: task);
                    },
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete_outline,
                            color: Colors.grey,
                          ),
                          8.w,
                          const Text(
                            AppString.deletedTask,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    key: Key(task.id),

                      child: TaskWidget(
                        task: task
                      )
                  );
                  })
              :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: tasks.isEmpty ? true : false
                          ),
                        ),
                      ),
                      FadeInUp(
                        from: 30,
                          child: const Text(
                              AppString.doneAllTask,
                            style: TextStyle(fontSize: 19),
                          ),
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

