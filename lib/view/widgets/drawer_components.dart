import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smallnotes/view/general/components/favorite.dart';
import 'package:smallnotes/view/widgets/header.dart';
import 'package:smallnotes/view/widgets/settings.dart';
import 'package:smallnotes/view/widgets/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/animation_route/bottom_to_top.dart';
import '../../constant/app_color.dart';
import 'widgets.dart';

class NoteDrawer extends NoteStatefulWidget {
  NoteDrawer({Key? key}) : super(key: key);

  @override
  State<NoteDrawer> createState() => _NoteDrawerState();
}

class _NoteDrawerState extends NoteState<NoteDrawer> {
  final Uri _urlTG = Uri.parse('https://t.me/+FdwYxaL9vos2NmYy');
  final Uri _urlINSTA = Uri.parse('https://www.instagram.com/flutter.uiux/');

  _favoriteNotes(BuildContext context) {
    bTtRoute(context: context, route: FavoritePG(), back: true);
  }

  _shareNoteApp() {}

  _rateNoteApp() {}

  _noteAppInformation(context) {
    final appPres = note.fmt(context, 'app.pres');
    return showDialog(
      barrierColor: Colors.black.withOpacity(.7),
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            content: Container(
              height: 100,
              width: 100,
              color: Colors.white12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(appPres,
                      style: ViewUtils.fStyle(
                          color: AppColors.black.value, bold: 5, fSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Telegram(onTap: _launchTelegram),
                      Instagram(onTap: _launchInstagram)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _launchTelegram() async {
    if (!await launchUrl(_urlTG,
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw 'Could not launch $_urlTG';
    }
  }

  void _launchInstagram() async {
    if (!await launchUrl(_urlINSTA,
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw 'Could not launch $_urlINSTA';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            height: 90,
            width: 90,
            alignment: Alignment.center,
            child: Image.asset('assets/img/notes.png'),
        ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          ListTile(
            title: Text(note.fmt(context, 'drawer.1')),
            leading: Icon(Icons.favorite, color: AppColors.red),
            onTap: () => _favoriteNotes(context),
          ),
          ListTile(
            title: Text(note.fmt(context, 'drawer.2')),
            leading: Icon(Icons.share, color: AppColors.grey),
            onTap: () => _shareNoteApp(),
          ),
          ListTile(
            title: Text(note.fmt(context, 'drawer.3')),
            leading: Icon(Icons.star, color: AppColors.yellow),
            onTap: () => _rateNoteApp(),
          ),
          ListTile(
              title: Text(note.fmt(context, 'drawer.4')),
              leading: Icon(Icons.settings, color: AppColors.grey),
              onTap: () =>
                  bTtRoute(context: context, route: Settings(), back: true)),
          ListTile(
            title: Text(note.fmt(context, 'drawer.5')),
            leading: Icon(Icons.info, color: AppColors.grey),
            onTap: () => _noteAppInformation(context),
          ),
        ],
      ),
    );
  }
}
