import 'package:coffee_plus/MainScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Colores principales de la paleta
        primaryColor: Color(0xFF6C4E31),  // Marrón oscuro
        scaffoldBackgroundColor: Color(0xFFFFEAC5),  // Melocotón claro

        // Configuración del esquema de colores
        colorScheme: ColorScheme(
          primary: Color(0xFF6C4E31),  // Marrón oscuro
          secondary: Color(0xFFFFDBB5),  // Melocotón suave
          surface: Color(0xFFFFEAC5),  // Fondo principal
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Color(0xFF603F26),  // Marrón profundo
          onSurface: Color(0xFF6C4E31),  // Marrón profundo
          onError: Colors.white,
          brightness: Brightness.light,
        ),

        // Estilo de la AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF6C4E31),
          foregroundColor: Colors.white,
        ),

        // Estilo de los botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFF603F26), backgroundColor: Color(0xFFFFDBB5),  // Marrón profundo para el texto
          ),
        ),
        fontFamily: "fall",

        useMaterial3: true,
        // Estilos de texto
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF603F26)),  // Marrón profundo
          bodyMedium: TextStyle(color: Color(0xFF6C4E31)),  // Marrón oscuro
        ),
       bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF6C4E31), // Fondo marrón oscuro
          selectedItemColor: Color(0xFF6C4E31), // Íconos seleccionados melocotón claro
          unselectedItemColor: Color.fromARGB(255, 207, 140, 67), // Íconos no seleccionados melocotón suave
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      home: MainScreen(),
    );
  }
}
