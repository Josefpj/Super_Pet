import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth para la autenticación de usuarios
import 'package:dm2_pet/Screens/login.dart'; // Importa la página de inicio de sesión
import 'package:dm2_pet/Screens/menu_page.dart'; // Importa la página del menú principal
import 'package:flutter/material.dart'; // Importa el paquete Flutter para crear interfaces de usuario

// Define la clase MainPage que extiende de StatelessWidget
class MainPage extends StatelessWidget {
  const MainPage({super.key}); // Constructor de la clase MainPage

  @override
  // Construye el widget principal
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // Escucha los cambios en el estado de autenticación
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Si hay un usuario autenticado
            return const MenuPage(); // Muestra la página del menú principal
          } else {
            // Si no hay un usuario autenticado
            return const LoginPage(); // Muestra la página de inicio de sesión
          }
        },
      ),
    );
  }
}
