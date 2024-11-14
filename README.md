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

El diagrama de clases de la aplicación incluye las clases principales `Reciepe`, `RecipeCardWidget`, y `DatabaseHelper`:

```plaintext
┌───────────────────────────┐
│        DatabaseHelper     │
├───────────────────────────┤
│ - _instance: DatabaseHelper │
│ - _database: Database?    │
├───────────────────────────┤
│ + database: Future<Database> │
│ + _initDatabase(): Future<Database> │
│ + insertRecipe(recipe: Reciepe): Future<void> │
│ + getAllRecipes(): Future<List<Reciepe>> │
│ + updateRecipe(recipe: Reciepe): Future<void> │
│ + deleteRecipe(id: int): Future<void> │
└───────────────────────────┘

┌───────────────────────────┐
│         Reciepe           │
├───────────────────────────┤
│ + id: int?                │
│ + nombre: String          │
│ + descripcion: String     │
│ + ingredientes: String    │
│ + preparacion: String     │
│ + imagenUrl: String       │
│ + isAssetImage: bool      │
│ + dateCreated: DateTime   │
├───────────────────────────┤
│ + toMap(): Map<String, dynamic> │
│ + fromMap(Map<String, dynamic>): Reciepe │
└───────────────────────────┘

┌───────────────────────────┐
│    RecipeCardWidget       │
├───────────────────────────┤
│ - receta: Reciepe         │
│ - isFavorite: bool        │
│ - onFavoriteToggle: void Function(Reciepe) │
│ - onRate: void Function(Reciepe) │
├───────────────────────────┤
│ + build(BuildContext): Widget │
└───────────────────────────┘
