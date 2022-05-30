import 'package:flutter/material.dart';
import 'package:smallnotes/view/constant/app_color.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class FavoriteNum extends NoteStatelessWidget {
  FavoriteNum({required this.favoriteNum, Key? key}) : super(key: key);
  final int favoriteNum;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>  Navigator.pushNamed(context, '/favoritePG'),
      child: Container(
        height: 55,
        width: 66,
        decoration: ViewUtils.decorationForProfAppBar(AppColors.red),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.favorite, color: AppColors.red),
            Text('$favoriteNum', style: TextStyle(color: AppColors.red))
          ],
        ),
      ),
    );
  }
}
