import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth para la autenticación de usuarios
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart'; // Importa el paquete Flutter para crear interfaces de usuario
import 'package:flutter/services.dart'; // Importa el paquete para trabajar con input formatters
import 'package:dm2_pet/Recursos/responsive.dart'; //importa el paqueta para trabajar con el responsive
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Define la clase LoginPage que extiende de StatefulWidget
class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => RegistroPageState();
}

// Define el estado asociado a RegistroPage
class RegistroPageState extends State<RegistroPage> {
  File? image;
  bool imageTaken = false;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController dni = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();
  final firebaseFirest = FirebaseFirestore.instance;

  registroUsuario() async {
    try {
      await firebaseFirest.collection('users').doc().set({
        //Registra en el firestore, en el formato establecido
        "Nombre": nombre.text,
        "Apellido": apellido.text,
        "DNI": dni.text,
        "Correo": correo.text,
        "Contraseña": password.text,
      });
    } catch (e) {
      print('Rellene los campos: $e');
    }
  }

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

    // Construye el widget principal
    return Scaffold(
      backgroundColor: Colors.teal[100], // Establece el color de fondo
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: responsive.height(1)),

              //Imagen del logo
              Image.asset(
                'assets/logo.png', // Ruta de la imagen del logo
                width: responsive.width(60),
                height: responsive.height(8),
              ),
              SizedBox(height: responsive.height(0.5)),

              // Mostrar Imagen Capturada
              if (image != null)
                Padding(
                  padding: EdgeInsets.all(responsive.height(2)),
                  child: Container(
                    width: responsive.width(40),
                    height: responsive.height(20),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              // Botón Capturar Imagen
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.width(25)),
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

              //Campo de texto para el nombre
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
                child: TextField(
                  controller: nombre,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z" "]')), // Permite solo letras
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
                    labelText: "Nombre", //Texto de sugerencia
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: responsive.height(2)),

              //Campo de texto para el apellido
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
                child: TextField(
                  controller: apellido,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z" "]')), // Permite solo letras
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
                    labelText: "Apellido", //Texto de sugerencia
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: responsive.height(2)),

              //Campo de texto para el DNI
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
                child: TextField(
                  controller: dni,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')), // Permite solo números
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
                    labelText: "DNI", //Texto de sugerencia
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: responsive.height(2)),

              //Campo de texto para correo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
                child: TextField(
                  controller: correo,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9.@]')), // Permite solo números
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
                    labelText: "Correo", //Texto de sugerencia
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: responsive.height(2)),

              //Campo de texto para contraseña
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
                child: TextField(
                  obscureText: true, // Oculta el texto de la contraseña
                  controller: password,
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
              SizedBox(height: responsive.height(2)),

              //Boton Registrar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.width(10)),
                child: GestureDetector(
                  onTap:
                      registroUsuario, // Llama a la función de registro usuario
                  child: Container(
                    padding: EdgeInsets.all(responsive.height(1.8)),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Registrar",
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
            ],
          ),
        ),
      ),
    );
  }
}
