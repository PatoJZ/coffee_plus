import 'dart:convert';

import 'package:coffee_plus/RecipeCardWidget.dart';
import 'package:coffee_plus/reciepe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Reciepe>> cargarRecetasDesdeJSON() async {
  final String response = await rootBundle.loadString('assets/recetas.json');
  final List<dynamic> data = json.decode(response);

  return data.map((json) => Reciepe.fromJson(json)).toList();
}

class MyBaristaScreen extends StatefulWidget {
  const MyBaristaScreen({super.key});

  @override
  _MyBaristaScreenState createState() => _MyBaristaScreenState();
}

class _MyBaristaScreenState extends State<MyBaristaScreen> {
 List<Reciepe> _recetas = [];

  @override
  void initState() {
    super.initState();
      _loadRecipes();
  }
 Future<void> _loadRecipes() async {
     _recetas = await cargarRecetasDesdeJSON();
    setState(() {}); // Actualiza el estado después de cargar las recetas
  }

// Función para editar el nombre de la receta
    Future<void> _editRecipe(Reciepe receta) async {
    final recetaEditada = await _showRecipeForm(receta);
    if (recetaEditada != null) {
      setState(() {
        // Encuentra el índice de la receta original en la lista y reemplázala
        final index = _recetas.indexOf(receta);
        if (index != -1) {
          _recetas[index] = recetaEditada;
        }
      });
    }
    }

// Modifica `_mostrarDialogoEdicion` para retornar un mapa de valores editados
  Future<Reciepe?> _showRecipeForm([Reciepe? receta]) async {
  TextEditingController nombreController = TextEditingController(text: receta?.nombre);
  TextEditingController descripcionController = TextEditingController(text: receta?.descripcion);
  TextEditingController preparacionController = TextEditingController(text: receta?.preparacion);
  TextEditingController ingredientesController = TextEditingController(text: receta?.ingredientes);

  return showDialog<Reciepe>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(receta == null ? "Nueva Receta" : "Editar Receta"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: ingredientesController,
              decoration: const InputDecoration(labelText: "Ingredientes"),
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: "Descripción"),
            ),
            TextField(
              controller: preparacionController,
              decoration: const InputDecoration(labelText: "Preparación"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            final recetaNueva = Reciepe(
              nombre: nombreController.text,
              descripcion: descripcionController.text,
              imagenUrl: receta?.imagenUrl ?? '', // Usa la URL actual
              ingredientes: ingredientesController.text,
              preparacion: preparacionController.text,
              isAssetImage: receta?.isAssetImage ?? false, // Conserva el valor original
            );

            Navigator.pop(context, recetaNueva);
          },
          child: const Text("Guardar"),
        ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Barista')),
      body: _recetas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recetas.length,
              itemBuilder: (context, index) {
                final receta = _recetas[index];
                return RecipeCardWidget(
                  receta: receta,
                  isFavorite: false,
                  onFavoriteToggle: (receta) {},
                  onRate: (receta) {},
                  onEdit: () => _editRecipe(receta),
                );
              },
            ),
    );
  }
}
