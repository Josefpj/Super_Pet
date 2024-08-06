import 'package:dm2_pet/Recursos/cadenas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:dm2_pet/Recursos/responsive.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    // Obtener el ancho y alto de la pantalla
    final responsive = Responsive(context);

    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: responsive.height(1)),

            //Imagen del logo
            Image.asset(
              'assets/logo.png', // Ruta de la imagen del logo
              width: responsive.width(60),
              height: responsive.height(15),
            ),

            SizedBox(height: responsive.height(1)),

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
            SizedBox(height: responsive.height(1)),

            // Mostrar Imagen Capturada

            //Boton Consultar Perfil
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
              child: GestureDetector(
                //onTap: registroUsuario, // Llama a la función de registro usuario
                child: Container(
                  padding: EdgeInsets.all(responsive.height(1.8)),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Consultar Perfil",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.fontSize(2.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: responsive.height(2)),

            //Boton Consultar Mascota
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
              child: GestureDetector(
                //onTap: signIn, // Llama a la función signIn al tocar el botón
                child: Container(
                  padding: EdgeInsets.all(responsive.height(1.8)),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Consultar Mascota",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.fontSize(2.3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: responsive.height(2)),

            //Boton Consultar Cita
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
              child: GestureDetector(
                //onTap: registroUsuario, // Llama a la función de registro usuario
                child: Container(
                  padding: EdgeInsets.all(responsive.height(1.8)),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Consultar Cita",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.fontSize(2.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: responsive.height(2)),

            //Boton de cerrar sesión
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
                icon: Icon(
                  Icons.exit_to_app,
                  size: responsive.iconSize(4),
                ),
                color: Colors.white,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
