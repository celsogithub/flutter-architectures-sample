import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {

  final int bottomIndex;
  final ValueChanged<int> onBottomSelected;

  BottomNavigation({
    @required this.bottomIndex,
    @required this.onBottomSelected
  });

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Tasks'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle),
          title: Text('Completed'),
        ),
      ],
      currentIndex: widget.bottomIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) => widget.onBottomSelected(index),
    );
  }
}
