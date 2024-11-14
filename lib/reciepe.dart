class Reciepe {
  final int? id; // Campo opcional para el ID de la base de datos
  final String nombre;
  final String descripcion;
  final String ingredientes;
  final String preparacion;
  final String imagenUrl;
  final bool isAssetImage; // Nuevo campo para identificar si es un asset

  Reciepe({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.ingredientes,
    required this.preparacion,
    required this.imagenUrl,
    this.isAssetImage = true,
  });

  // Convertir un objeto Reciepe a un mapa para guardar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': nombre,
      'ingredients': ingredientes,
      'steps': preparacion,
      'imagePath': imagenUrl,
      'isAssetImage': isAssetImage ? 1 : 0, // Convertir bool a int
      'dateCreated': DateTime.now().toIso8601String(), // Fecha de creación
    };
  }

  // Crear un objeto Reciepe a partir de un mapa de la base de datos
  factory Reciepe.fromMap(Map<String, dynamic> map) {
    return Reciepe(
      id: map['id'],
      nombre: map['name'],
      ingredientes: map['ingredients'],
      preparacion: map['steps'],
      imagenUrl: map['imagePath'],
      isAssetImage: map['isAssetImage'] == 1, // Convertir int a bool
      descripcion: map['description'] ?? '',
    );
  }

  // Crear un objeto Reciepe a partir de un JSON
  factory Reciepe.fromJson(Map<String, dynamic> json) {
    return Reciepe(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      ingredientes: json['ingredientes'],
      preparacion: json['Preparacion'],
      imagenUrl: json['imagenUrl'],
      isAssetImage: json['isAssetImage'] ?? true,
    );
  }
}
