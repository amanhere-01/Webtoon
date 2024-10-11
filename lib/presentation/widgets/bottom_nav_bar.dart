import 'package:flutter/material.dart';
import 'package:webtoon/presentation/pages/favorite_page.dart';
import 'package:webtoon/presentation/pages/home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  List pages = [const HomePage(), const FavoritePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        onTap: (index){
          setState(() {
            selectedIndex= index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined),
              label: 'Favorites'
          ),
        ]
      ),
      body: pages[selectedIndex],
    );
  }
}
