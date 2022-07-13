import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/general/favorite_page/favorite.dart';
import 'package:smallnotes/view/widgets/utils.dart';

class FavoriteNum extends NoteStatelessWidget {
  FavoriteNum({required this.numF, Key? key}) : super(key: key);
  final int numF;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => rTlRoute(context: context, route: FavoritePG(), back: true),
      child: Container(
        height: 55,
        width: 66,
        decoration: ViewUtils.favoriteNumCard(),
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
