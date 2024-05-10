//lotties aset adress
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:my_todo_app/utils/app_str.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

String lottieURL = 'assets/lottie/1.json';

// Empty title or subtitle textfield warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'Vous devez remplir tout les champs',
      corner: 20,
      duration: 2000,
      padding: const EdgeInsets.all(20));
}

// Nothing entered when user try to edit or update task
dynamic updateWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'Vous devez remplir tout les champs',
      corner: 20,
      duration: 5000,
      padding: const EdgeInsets.all(20));
}

// No task warning dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message: 'Tu n\'as actuellement aucune task enregistrée.',
    buttonText: 'Okay',
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning
  );
}

dynamic deleteAllTasksWarning(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.oopsMsg,
    message: 'T\'es vraiment sûr de toi là ? Si tu supprime tu pers toutes les tasks. Tu confirme ?',
    cancelButtonText: 'Nop',
    confirmButtonText: 'Wesh',
    onTapConfirm: () {
      // Clear all box data
      // BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false
  );
}
