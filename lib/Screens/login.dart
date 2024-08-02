import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth para la autenticación de usuarios
import 'package:flutter/material.dart'; // Importa el paquete Flutter para crear interfaces de usuario
import 'package:flutter/services.dart'; // Importa el paquete para trabajar con input formatters

// Define la clase LoginPage que extiende de StatefulWidget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); // Constructor de la clase LoginPage

  @override
  State<LoginPage> createState() =>
      _LoginPageState(); // Crea el estado para LoginPage
}

// Define el estado asociado a LoginPage
class _LoginPageState extends State<LoginPage> {
  // Controladores para los campos de texto de usuario y contraseña
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();

  // Función asincrónica para iniciar sesión usando Firebase Auth
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usuarioController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    // Limpia los controladores cuando el widget se destruye
    usuarioController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Construye el widget principal
    return Scaffold(
      backgroundColor: Colors.teal[100], // Establece el color de fondo
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 150),

              //Imagen del logo
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png', // Ruta de la imagen del logo
                    width: 300,
                    height: 100,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              //Campo de texto para el email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: usuarioController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        r'[a-zA-Z0-9.@]')), // Permite solo letras, números, puntos y @
                  ],
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Email", //Texto de sugerencia
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //Campo de texto para la contraseña
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  obscureText: true, // Oculta el texto de la contraseña
                  controller: passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Contraseña", //Texto de sugerencia
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //Boton Ingresar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: signIn, // Llama a la función signIn al tocar el botón
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Ingresar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //Boton Registrar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap:
                      signIn, // Llama a la función de registro (Falta cambiar)
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Resgistrar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //Texto de Olvidaste contraseña
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
