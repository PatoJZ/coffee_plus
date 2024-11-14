import 'dart:io';
import 'package:coffee_plus/reciepe.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class RecipeCardWidget extends StatelessWidget {
  final Reciepe receta;
  final bool isFavorite;
  final Function(Reciepe) onFavoriteToggle;
  final Function(Reciepe) onRate;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  const RecipeCardWidget({
    Key? key,
    required this.receta,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onRate,
    required this.onEdit,
    this.onDelete,
  }) : super(key: key);

  void _shareRecipe() {
    final String recipeText = '''
Receta: ${receta.nombre}

Ingredientes: ${receta.ingredientes}

Descripción: ${receta.descripcion}

Preparación: ${receta.preparacion}
    ''';

    Share.share(recipeText);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFDBB5),
      margin: const EdgeInsets.all(10),
      child: ExpansionTile(
        leading: receta.isAssetImage
            ? Image.asset(receta.imagenUrl,
                width: 50, height: 50, fit: BoxFit.cover)
            : Image.file(File(receta.imagenUrl),
                width: 50, height: 50, fit: BoxFit.cover),
        title: Text(
          receta.nombre,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6C4E31)),
        ),
        subtitle: Text('Ingredientes: ${receta.ingredientes}',
            style: const TextStyle(color: Color(0xFF603F26))),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.green),
              onPressed: _shareRecipe, // Botón de compartir
            ),
          ],
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Descripción: ${receta.descripcion}",
                    style: const TextStyle(color: Color(0xFF603F26))),
                const SizedBox(height: 8),
                Text("Preparación: ${receta.preparacion}",
                    style: const TextStyle(color: Color(0xFF603F26))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
