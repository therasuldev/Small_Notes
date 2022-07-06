import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class Telegram extends NoteStatelessWidget {
   Telegram({Key? key, this.onTap}) : super(key: key);
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset('assets/svg/telegram.svg', height: 50, width: 50),
    );
  }
}

class Instagram extends NoteStatelessWidget {
   Instagram({Key? key, this.onTap}) : super(key: key);
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          SvgPicture.asset('assets/svg/instagram.svg', height: 50, width: 50),
    );
  }
}
