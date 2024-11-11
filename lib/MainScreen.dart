import 'package:coffee_plus/HomeScreen.dart';
import 'package:coffee_plus/MyRecipesScreen.dart';
import 'package:flutter/material.dart';
import 'package:coffee_plus/FeedbackScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    //MyBaristaScreen(),
    const MyRecipesScreen(),
    const FeedbackScreen(),
    //SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.local_cafe), label: 'Mi Barista'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Mis Recetas'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Opinión'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuración'),
        ],
      ),
    );
  }
}