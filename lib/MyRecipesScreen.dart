import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MyRecipesScreen extends StatefulWidget {
  const MyRecipesScreen({super.key});

  @override
  _MyRecipesScreenState createState() => _MyRecipesScreenState();
}

class _MyRecipesScreenState extends State<MyRecipesScreen> {
  void _shareRecipe(String recipe) {
    Share.share('Mira esta receta de café: $recipe');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Recetas'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _shareRecipe('Receta de Café Especial'),
          child: const Text('Compartir Receta'),
        ),
      ),
    );
  }
}
