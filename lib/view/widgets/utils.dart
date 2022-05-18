import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:smallnotes/view/constant/color_constant.dart';

class ViewUtils {
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
      title: Text(title),
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
    return showBottomSheet(
      context: context,
      enableDrag: true,
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

  static bottomSHEET({
    required BuildContext context,
    required void Function(int) changeTextColor,
  }) {
    return showBottomSheet(
      enableDrag: true,
      shape: ViewUtils.shapeBorder(),
      backgroundColor: Colors.blueGrey,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 80,
          child: Center(
            child: ListView.builder(
              itemBuilder: (contex, index) {
                int select = 0;
                select = index;
                return InkWell(
                  onTap: () => changeTextColor(select),
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: ViewUtils.formDecoration(),
                    child: Container(
                      height: 35,
                      width: 35,
                      color: select == 0 ? AppColors.black : AppColors.grey,
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: 2,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
    );
  }

  static formDecoration() {
    return BoxDecoration(
      color: AppColors.brownLight,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.black, width: .5),
    );
  }

  static smallDecoration() {
    return BoxDecoration(
      color: AppColors.blueGrey,
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
    );
  }

  static decorationForProfAppBar(Color color) {
    return BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: color, width: 2),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static shapeBorder() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)));
  }

  static buttonStyle() {
    return ElevatedButton.styleFrom(primary: AppColors.blueGrey, elevation: 20);
  }

  static toolbarOptions() {
    return const ToolbarOptions(
      paste: true,
      copy: true,
      cut: true,
      selectAll: true,
    );
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
