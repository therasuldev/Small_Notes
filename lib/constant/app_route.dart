import 'package:flutter/material.dart';
import 'package:smallnotes/view/general/components/favorite.dart';
import 'package:smallnotes/view/general_home.dart';


import '../view/general/profile/profile.dart';
import '../view/general/profile/show_item.dart';

class AppRoute {
  static get generalHome => GeneralHome();
  static get favoritePG => FavoritePG();
  static get showItem => ShowItem();
  static get profilePG=>Profile();

  Map<String, Widget Function(BuildContext)> appRoutes = {
    '/generalHome': (context) => AppRoute.generalHome,
    '/favoritePG': (context) => AppRoute.favoritePG,
    '/showItem': (context) => AppRoute.showItem,
    '/profilePG':(context)=>AppRoute.profilePG,
  };
  
}
