import 'package:coffee_plus/RecipeCardWidget.dart';
import 'package:coffee_plus/database.dart';

import 'package:coffee_plus/reciepe.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
 // Asegúrate de importar DatabaseHelper aquí

class MyRecipesScreen extends StatefulWidget {
  const MyRecipesScreen({super.key});

  @override
  _MyRecipesScreenState createState() => _MyRecipesScreenState();
}

class _MyRecipesScreenState extends State<MyRecipesScreen> {
  List<Reciepe> misRecetas = [];
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  bool _isLoadingImage = false;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final recipes = await DatabaseHelper.instance.getAllRecipes();
    setState(() {
      misRecetas = recipes;
    });
  }

  Future<void> _addNewRecipe() async {
    final nuevaReceta = await _showRecipeForm();
    if (nuevaReceta != null) {
      await DatabaseHelper.instance.insertRecipe(nuevaReceta);
      setState(() {
        misRecetas.add(nuevaReceta);
      });
    }
  }

  Future<void> _editRecipe(Reciepe receta) async {
    final recetaEditada = await _showRecipeForm(receta);
    if (recetaEditada != null) {
      await DatabaseHelper.instance.updateRecipe(recetaEditada);
      setState(() {
        _loadRecipes();
      });
    }
  }

  Future<void> _deleteRecipe(int id) async {
    await DatabaseHelper.instance.deleteRecipe(id);
    setState(() {
      _loadRecipes();
    });
  }

  Future<Reciepe?> _showRecipeForm([Reciepe? receta]) async {
    TextEditingController nombreController = TextEditingController(text: receta?.nombre);
    TextEditingController descripcionController = TextEditingController(text: receta?.descripcion);
    TextEditingController preparacionController = TextEditingController(text: receta?.preparacion);
    TextEditingController ingredientesController = TextEditingController(text: receta?.ingredientes);

    return showDialog<Reciepe>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(receta == null ? "Nueva Receta" : "Editar Receta"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nombreController, decoration: InputDecoration(labelText: "Nombre")),
              TextField(controller: ingredientesController, decoration: InputDecoration(labelText: "Ingredientes")),
              TextField(controller: descripcionController, decoration: InputDecoration(labelText: "Descripción")),
              TextField(controller: preparacionController, decoration: InputDecoration(labelText: "Preparación")),
              ElevatedButton(
                onPressed: () async {
                  setState(() => _isLoadingImage = true);
                  _imageFile = await _picker.pickImage(source: ImageSource.camera);
                  setState(() => _isLoadingImage = false);
                },
                child: Text("Tomar Foto"),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() => _isLoadingImage = true);
                  _imageFile = await _picker.pickImage(source: ImageSource.gallery);
                  setState(() => _isLoadingImage = false);
                },
                child: Text("Seleccionar de Galería"),
              ),
              if (_isLoadingImage) const CircularProgressIndicator(),
              if (_imageFile != null) const Text("Foto cargada correctamente"),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
            TextButton(
              onPressed: () {
                final recetaNueva = Reciepe(
                  nombre: nombreController.text,
                  descripcion: descripcionController.text,
                  imagenUrl: _imageFile?.path ?? receta?.imagenUrl ?? '',
                  ingredientes: ingredientesController.text,
                  preparacion: preparacionController.text,
                  isAssetImage: _imageFile == null,
                );
                
                Navigator.pop(context, recetaNueva);
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mis Recetas")),
      body: misRecetas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Añade tu primera receta"),
                  const SizedBox(height: 20),
                  FloatingActionButton(
                    onPressed: _addNewRecipe,
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            )
          : ListView(
              children: misRecetas
                  .map((receta) => RecipeCardWidget(
                        receta: receta,
                        isFavorite: false,
                        onFavoriteToggle: (receta) {},
                        onRate: (receta) {},
                        onEdit: () => _editRecipe(receta),
                        onDelete: () => _deleteRecipe(receta.id!),
                      ))
                  .toList(),
            ),
      floatingActionButton: misRecetas.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: _addNewRecipe,
              child: Icon(Icons.add),
            ),
    );
  }
}
