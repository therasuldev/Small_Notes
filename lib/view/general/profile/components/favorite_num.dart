import 'package:flutter/material.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class FavoriteNum extends NoteStatelessWidget {
  FavoriteNum({required this.numF, Key? key}) : super(key: key);
  final int numF;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/favoritePG'),
      child: Container(
        height: 55,
        width: 66,
        decoration: ViewUtils.kDecor(
            color: AppColors.white.value,
            borderColor: AppColors.red.value,
            borderWidth: 2,
            tL: 10,
            tR: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.favorite, color: AppColors.red),
            Text('$numF', style: TextStyle(color: AppColors.red))
          ],
        ),
      ),
    );
  }
}
