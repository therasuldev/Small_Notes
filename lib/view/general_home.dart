import 'package:flutter/material.dart';
import 'package:smallnotes/view/constant/color_constant.dart';
import 'package:smallnotes/view/general/home/home.dart';
import 'package:smallnotes/view/general/profile/profile.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

class GeneralHome extends NoteStatefulWidget {
  GeneralHome({Key? key}) : super(key: key);

  @override
  State<GeneralHome> createState() => _GeneralHomeState();
}

class _GeneralHomeState extends NoteState<GeneralHome> {
  var initialIndex = 0;
  final _pages = <NoteStatefulWidget>[Home(), Profile()];

  void pageChanged(int index) => setState(() => initialIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) => pageChanged(value),
        children: [_pages.elementAt(initialIndex)],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    final noteAdd = note.fmt(context, 'bottom_navbar.note.add');
    final notes = note.fmt(context, 'bottom_navbar.notes');
    return BottomNavigationBar(
      onTap: (int index) => pageChanged(index),
      currentIndex: initialIndex,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.note_add), label: noteAdd),
        BottomNavigationBarItem(icon: const Icon(Icons.notes), label: notes)
      ],
      selectedItemColor: AppColors.selectedColor,
      unselectedItemColor: AppColors.black,
    );
  }
}
