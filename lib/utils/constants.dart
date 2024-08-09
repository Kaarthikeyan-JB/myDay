

import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:res/main.dart';
import 'package:res/utils/app_strings.dart';

String lottieURL = 'assets/lottie/TaskComplete.json';

dynamic emptyWarning(BuildContext context){
  return FToast.toast(
      context,
    msg: AppString.oopsMsg,
    subMsg: "You must fill All fields!",
    corner: 20,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

dynamic updateTaskWarning(BuildContext context){
  return FToast.toast(
    context,
    msg: AppString.oopsMsg,
    subMsg: "You must edit the tasks then try to update it!!",
    corner: 20,
    duration: 5000,
    padding: const EdgeInsets.all(20),
  );
}

dynamic noTaskWarning(BuildContext context){
  return PanaraInfoDialog.showAnimatedGrow(
      context,
      title: AppString.oopsMsg,
      message: "There is no Task to delete!",
      buttonText: "Okay",
      onTapDismiss: (){
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.warning,);
}

dynamic deleteAllTask(BuildContext context){
  return PanaraConfirmDialog.show(
      context,
      title: AppString.areYouSure,
      message: "Do you want to delete all tasks? You will not be able to undo this action!",
      confirmButtonText: "Yes",
      cancelButtonText: "No",
      onTapConfirm: (){
        BaseWidget.of(context).dataStore.box.clear();
        Navigator.pop(context);
      },
      onTapCancel: (){
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false
  );
}