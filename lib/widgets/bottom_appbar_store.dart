import 'package:flutter/material.dart';

class BottomAppBarStore extends StatelessWidget {
  const BottomAppBarStore({
    super.key,
    required this.selectedPageIndex,
    required this.onPageSelected,
  });

  final int selectedPageIndex;
  final Function(int) onPageSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedPageIndex,
      onTap: onPageSelected,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      ],
    );
  }
}
