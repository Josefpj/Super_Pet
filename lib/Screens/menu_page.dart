import 'package:dm2_pet/Recursos/cadenas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dm2_pet/Recursos/responsive.dart';
import 'dart:io';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  File? image;
  bool imageTaken = false;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;
      final imageTemporary = File(pickedImage.path);

      // Sube la imagen a Firebase Storage
      final imageURL = await uploadImageToFirebaseStorage(imageTemporary);

      setState(() {
        this.image = imageTemporary;
        imageTaken = true;
      });
    } on PlatformException catch (e) {
      print('Fallo al tomar la imagen: $e');
    }
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return '';

      final Reference storageReference = _storage
          .ref()
          .child('images/${user.uid}/${DateTime.now().toString()}.jpg');
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      final String imageURL = await snapshot.ref.getDownloadURL();

      return imageURL;
    } catch (e) {
      print('Error al cargar la imagen en Firebase Storage: $e');
      return '';
    }
  }

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
            if (image != null)
              Padding(
                padding: EdgeInsets.all(responsive.height(2)),
                child: Container(
                  width: responsive.width(80),
                  height: responsive.height(40),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: responsive.height(1)),

            // Botón Capturar Imagen
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
              child: GestureDetector(
                onTap: () async {
                  await pickImage(); // Llama a la función pickImage al tocar el botón
                },
                child: Container(
                  padding: EdgeInsets.all(responsive.height(1.8)),
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Capturar Imagen",
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
