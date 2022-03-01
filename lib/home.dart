import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultima_conexion/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ultima_conexion/database.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('personas');

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> people =
      FirebaseFirestore.instance.collection('person').snapshots();
  @override
  void initState() {
    super.initState();
  }

  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final edad = TextEditingController();
  final id = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    nombre.dispose();
    apellido.dispose();
    edad.dispose();
    id.dispose();
    super.dispose();
  }

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: people,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Text("someting went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("loading");
                  }
                  final data = snapshot.requireData;

                  return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      //return Text('my name is ${data.docs[index]['name']} and age is ${data.docs[index]['age']}');
                      return TextButton(
                          child: Text('${data.docs[index]['name']} ${data.docs[index]['age']}'),
                          onPressed: () {
                            
                          });
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: id,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'ID (Actualizar, Buscar y Eliminar)',
              ),
              keyboardType: TextInputType.datetime,
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            Divider(),
            TextField(
              controller: nombre,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Nombre',
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            Divider(),
            TextField(
              controller: apellido,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Apellido',
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            Divider(),
            TextField(
              controller: edad,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Edad',
              ),
              keyboardType: TextInputType.datetime,
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            Divider(),
            TextButton(
                child: Text('Insertar'),
                onPressed: () => Database.addItem(
                    nombre: nombre.text,
                    apellido: apellido.text,
                    edad: edad.text)),
            TextButton(
                child: Text('Actualizar'),
                onPressed: () => Database.updateItem(
                    nombre: nombre.text,
                    apellido: apellido.text,
                    edad: edad.text,
                    docId: id.text)),
            TextButton(
                child: Text('Eliminar'),
                onPressed: () => Database.deleteItem(docId: id.text)),
            TextButton(
                child: Text('Ir al home'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ConsMain()));
                }),
          ],
        ),
      ),
    );
  }
}