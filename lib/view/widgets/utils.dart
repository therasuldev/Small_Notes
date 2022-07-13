import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:smallnotes/note.dart';

class ViewUtils {
  static underlineBorderDecoration({String? hint}) {
    final underlineInputBorder =
        UnderlineInputBorder(borderSide: BorderSide(color: AppColors.blue));
    return InputDecoration(
      hintText: hint,
      border: underlineInputBorder,
      focusedBorder: underlineInputBorder,
      enabledBorder: underlineInputBorder,
      errorBorder: InputBorder.none,
      disabledBorder: underlineInputBorder,
      focusedErrorBorder: InputBorder.none,
      hintStyle: TextStyle(color: AppColors.brownAccent),
    );
  }

  static nonBorderDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      hintStyle: TextStyle(color: AppColors.brownAccent),
    );
  }

  static generalBStyle(
    BuildContext context, {
    Color color = Colors.black,
    Color backgroundColor = Colors.transparent,
    double radius = 0,
    double stroke = 1.5,
    bool borderEnabled = true,
    Size size = const Size(0, 40),
  }) {
    return ButtonStyle(
        overlayColor: MaterialStateProperty.all(color.withOpacity(.1)),
        fixedSize: MaterialStateProperty.all(size),
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: borderEnabled
                ? BorderSide(color: color, width: stroke)
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ));
  }

  static AlertDialog generateDialog(
    BuildContext context, {
    required String title,
    required String cancelTitle,
    required String actTitle,
    required Function() onAct,
    Color actColor = Colors.red,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title, maxLines: 2, style: const TextStyle(fontSize: 17)),
      actions: [
        TextButton(
          key: const Key('cancel.button'),
          child: Text(cancelTitle, style: const TextStyle(color: Colors.blue)),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          style: ViewUtils.generalBStyle(
            context,
            color: actColor,
            borderEnabled: false,
          ),
          onPressed: onAct,
          child: Text(actTitle, style: const TextStyle(color: Colors.red)),
        )
      ],
    );
  }

  static bottomSheet({
    required BuildContext context,
    required String selectColor,
    required String changeColor,
    required Color pickerColor,
    required void Function(Color) changePickerColor,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: ViewUtils.shapeBorder(),
      backgroundColor: AppColors.brown200,
      builder: (context) {
        const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(selectColor, style: style),
              const SizedBox(height: 10),
              ColorPicker(
                  pickerColor: pickerColor, onColorChanged: changePickerColor),
              const SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }

  static selectTextColorSheet({
    required BuildContext context,
    required String textColor,
    required Color pickerColor,
    required void Function(Color) changePickerColor,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: ViewUtils.shapeBorder(),
      backgroundColor: AppColors.brown200,
      builder: (context) {
        const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(textColor, style: style),
              const SizedBox(height: 10),
              ColorPicker(
                  pickerColor: pickerColor, onColorChanged: changePickerColor),
              const SizedBox(height: 10)
            ],
          ),
        );
      },
    );
  }

  static favoriteCard({int? color}) {
    return BoxDecoration(
      color: Color(color ?? 0x00000000),
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(35),
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      border: Border.all(color: AppColors.black, width: .5),
    );
  }

  static showAndEditItemCard({int? color}) {
    return BoxDecoration(color: Color(color ?? 0x00000000));
  }

  static settingsCard() {
    return BoxDecoration(
      color: AppColors.grey.withOpacity(.2),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static itemCard({int? color, int? borderColor}) {
    return BoxDecoration(
      color: Color(color ?? 0x00000000),
      borderRadius: BorderRadius.circular(7),
      border: Border.all(
        color: Color(borderColor ?? color ?? 0xFF000000),
        width: 2,
      ),
    );
  }

  static textAndTitleCard({int? color, int? borderColor}) {
    return BoxDecoration(
      color: AppColors.brownLight,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.black, width: .5),
    );
  }

  static noteNumCard() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      border: Border.all(color: AppColors.black, width: 2),
    );
  }

  static favoriteNumCard() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      border: Border.all(color: AppColors.red, width: 2),
    );
  }

  static defaultCard() {
    return BoxDecoration(
      color: AppColors.blueGrey,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    );
  }

  static catalogForItemCard() {
    return const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 202, 202, 202),
          spreadRadius: .5,
          blurRadius: 5,
          offset: Offset(-10, 0),
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(-5, 0),
        ),
      ],
    );
  }

  static shapeBorder() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    );
  }

  static buttonStyle() {
    return ElevatedButton.styleFrom(primary: AppColors.blueGrey, elevation: 20);
  }

  static fStyle({double? fSize, int? color, int? bold}) {
    return TextStyle(
        fontSize: fSize ?? 14,
        color: Color(color ?? 0x00000000),
        fontWeight: FontWeight.values[bold ?? 2]);
  }

  // showSnack shows easy-modifiable snack bar.
  static showSnack(
    BuildContext context, {
    required String msg,
    bool isFloating = false,
    required Color color,
    int sec = 4,
  }) async {
    final snack = SnackBar(
      content: Text(msg, style: TextStyle(color: AppColors.white)),
      duration: Duration(seconds: sec),
      margin: isFloating ? const EdgeInsets.all(8) : null,
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: isFloating
            ? BorderRadius.circular(8)
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
      ),
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
