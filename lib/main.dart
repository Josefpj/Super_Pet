import 'package:dm2_pet/main_page.dart'; // Importa la página principal del proyecto
import 'package:flutter/material.dart'; // Importa el paquete Flutter para crear interfaces de usuario
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase Core para inicializar Firebase
import 'package:dm2_pet/firebase_options.dart'; // Importa las opciones de configuración de Firebase para el proyecto

// La función principal del programa. Es el punto de entrada del aplicativo Flutter.
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que los widgets estén vinculados antes de inicializar Firebase
  await Firebase.initializeApp(
    // Inicializa Firebase con las opciones de configuración específicas de la plataforma actual
    options: DefaultFirebaseOptions.currentPlatform,
  );
// Ejecuta la aplicación Flutter
  runApp(const MyApp());
}

// Define la clase principal del aplicativo que extiende de StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor

  @override
  //Es un contenedor básico
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Devuelve un MaterialApp
      debugShowCheckedModeBanner:
          false, // Desactiva la marca de modo de depuración
      home: MainPage(), // Establece la página principal de la aplicación
    );
  }
}
