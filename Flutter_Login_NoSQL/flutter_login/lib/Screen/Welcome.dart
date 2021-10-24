import 'package:flutter/material.dart';
import 'package:flutter_login/Screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Column(
          children: [
            Text(
              _auth.currentUser!.email!,
            ),
            ElevatedButton(
                onPressed: () {
                  _auth.signOut().then((value) => {
                        Navigator.popUntil(context, (route) => false),
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }))
                      });
                },
                child: Text("Logout"))
          ],
        ));
  }
}
