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
