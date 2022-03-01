import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ultima_conexion/home.dart';
import 'package:ultima_conexion/images.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('personas');

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const ConsMain());
  });
}

class ConsMain extends StatelessWidget {
  const ConsMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Start(),
    );
  }
}

class Start extends StatefulWidget {
  Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video de Introducción"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text("Aqui el video"),
          Container(
            child: TextButton(
                child: Text('Ir a los Clientes'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home()));
                }),
          ),
          Container(
            child: TextButton(
                child: Text('Ir a los Clientes'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Images()));
                }),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
