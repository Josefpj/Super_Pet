import 'package:dm2_pet/Recursos/cadenas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: SafeArea(
        child: Center(
          child: Column(children: [
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
            const SizedBox(height: 20),

            //Texto de Bienvenida
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppCadenas.Titulo),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //Boton Consultar Mascota
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                //onTap: signIn, // Llama a la función signIn al tocar el botón
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Consultar Mascota",
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
            const SizedBox(height: 150),

            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  //exit(0);
                },
                icon: const Icon(Icons.exit_to_app),
                color: Colors.white,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
