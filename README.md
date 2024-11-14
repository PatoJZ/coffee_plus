# Coffee Time

## Descripción del Problema
Coffee Time es una aplicación diseñada para los amantes del café que desean crear, almacenar y gestionar recetas de café. La aplicación permite a los usuarios explorar recetas predefinidas, crear nuevas recetas con fotos personalizadas, y organizarlas cronológicamente desde la más reciente hasta la más antigua. También incluye la funcionalidad de marcar recetas como favoritas, compartirlas, y recibir feedback de los usuarios.

## Funcionalidades

1. **Gestión de Recetas**:
   - Crear recetas personalizadas, incluyendo la opción de tomar una foto o seleccionar una de la galería.
   - Visualizar recetas almacenadas, ordenadas de la más reciente a la más antigua.
   - Editar y eliminar recetas según sea necesario.

2. **Persistencia de Datos**:
   - Almacenar recetas en una base de datos local utilizando `sqflite`.
   - Recuperar recetas almacenadas al reiniciar la aplicación, asegurando que los datos de usuario sean persistentes.

3. **Interfaz de Navegación**:
   - Navegación principal entre pantallas de inicio, recetas personalizadas, barista (para ver recetas de los assets), y retroalimentación.

4. **Retroalimentación**:
   - Permitir a los usuarios calificar la aplicación en aspectos como usabilidad y contenido.
   - Enviar feedback recopilado a un correo electrónico designado.

## Diagrama de Clases

El diagrama de clases de la aplicación incluye las clases principales `Reciepe`, `RecipeCardWidget`, o `DatabaseHelper`:


```mermaid
classDiagram

class MainScreen {
  - int _currentIndex
  - List~Reciepe~ _recetas
  + initState() void
  + _loadRecipes() Future
  + cargarRecetasDesdeJSON() Future~List~Reciepe~~
  + build(context) Widget
}

class Main {
  + main() void
}

class DatabaseHelper {
  - Database? _database
  + instance: DatabaseHelper
  + database: Future~Database~
  + _initDatabase() Future~Database~
  + insertRecipe(recipe: Reciepe) Future~int~
  + getAllRecipes() Future~List~Reciepe~~
}

class FeedbackScreen {
  - List _questions
  + _sendEmail(content: String) Future~void~
  + build(context) Widget
}

class HomeScreen {
  - List~Reciepe~ _recetas
  + _loadAndSortRecetas() Future~void~
  + build(context) Widget
}

class MyBaristaScreen {
  - List~Reciepe~ _recetas
  + initState() void
  + _loadRecipes() Future
  + build(context) Widget
}

class MyRecipesScreen {
  - List~Reciepe~ _recetas
  + initState() void
  + _addNewRecipe() Future~void~
  + _showRecipeForm() Future~Reciepe?~
  + build(context) Widget
}

class Reciepe {
  - int? id
  - String nombre
  - String descripcion
  - String ingredientes
  - String preparacion
  - String imagenUrl
  - bool isAssetImage
  - DateTime dateCreated
  + toMap() Map~String, dynamic~
  + fromMap(Map~String, dynamic~) Reciepe
  + fromJson(Map~String, dynamic~) Reciepe
}

class RecipeCardWidget {
  - Reciepe receta
  - bool isFavorite
  - void Function(Reciepe) onFavoriteToggle
  - void Function(Reciepe) onRate
  + build(context) Widget
}

MainScreen --> Main
MainScreen --> HomeScreen
MainScreen --> MyBaristaScreen
MainScreen --> MyRecipesScreen
MainScreen --> FeedbackScreen
MainScreen --> Reciepe
MainScreen --> DatabaseHelper
MyBaristaScreen --> Reciepe
MyRecipesScreen --> Reciepe
RecipeCardWidget --> Reciepe
DatabaseHelper --> Reciepe
