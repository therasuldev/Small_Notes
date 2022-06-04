import 'package:flutter/material.dart';
import 'package:smallnotes/view/constant/app_route.dart';
import 'package:smallnotes/view/constant/app_size.dart';

import '../../../constant/app_color.dart';
import '../../../widgets/widgets.dart';

class NoteDrawer extends NoteStatelessWidget {
  NoteDrawer({Key? key}) : super(key: key);
  final route = AppRoute();

  _favoriteNotes(BuildContext context) {
    Navigator.pushNamed(context, route.appRoutes.keys.elementAt(1));
  }

  _shareNoteApp() {}

  _rateNoteApp() {}

  _noteAppInformation() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top) ,
          CircleAvatar(
              minRadius: 50,
              backgroundColor: AppColors.brown200,
              child: const FlutterLogo(size: 50)),
          const Padding(padding: EdgeInsets.only(top: 40)),
          ListTile(
            title: const Text('Favoritlər'),
            leading: Icon(Icons.favorite, color: AppColors.red),
            onTap: () => _favoriteNotes(context),
          ),
          ListTile(
            title: const Text('Paylaş'),
            leading: Icon(Icons.share, color: AppColors.black),
            onTap: () => _shareNoteApp(),
          ),
          ListTile(
            title: const Text('Bizi qiymətləndirin'),
            leading: Icon(Icons.star, color: AppColors.yellow),
            onTap: () => _rateNoteApp(),
          ),
          ListTile(
            title: const Text('Bizim haqqımızda'),
            leading: Icon(Icons.info, color: AppColors.grey),
            onTap: () => _noteAppInformation(),
          ),
        ],
      ),
    );
  }
}
