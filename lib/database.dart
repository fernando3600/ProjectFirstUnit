import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('personas');

class Database {
  static String? userUid;


//********************************************* */

//añadir 
  static Future<void> addItem({
  required String nombre,
  required String apellido,
  required String edad,
}) async {
  DocumentReference documentReferencer =
      _mainCollection.doc();

  Map<String, dynamic> data = <String, dynamic>{
    "nombre": nombre,
    "apellido": apellido,
    "edad": edad
  };

  await documentReferencer
      .set(data)
      .whenComplete(() => print("Notes item added to the database"))
      .catchError((e) => print(e));
}

//*********************************************** */

//Obtener usuarios

static getUsers() async{

    List personas = [];
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("personas");

    QuerySnapshot users = await  collectionReference.get();

    if(users.docs.length != 0){
      for(var doc in users.docs){
        personas.add(doc.data());
        
      }
    }
    return personas;
  }


//********************************************** */

//actualizar ususarios

static Future<void> updateItem({
  required String nombre,
  required String apellido,
  required String edad,
  required String docId,
}) async {
  DocumentReference documentReferencer =
      _mainCollection.doc(docId);

  Map<String, dynamic> data = <String, dynamic>{
    "nombre": nombre,
    "apellido": apellido,
    "edad": edad
  };

  await documentReferencer
      .update(data)
      .whenComplete(() => print("Note item updated in the database"))
      .catchError((e) => print(e));
}

//************************************************** */
// eliminar documento 

static Future<void> deleteItem({
  required String docId,
}) async {
  DocumentReference documentReferencer =
      _mainCollection.doc(docId);

  await documentReferencer
      .delete()
      .whenComplete(() => print('Note item deleted from the database'))
      .catchError((e) => print(e));
}


//**************************************** */
//imagenes

final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile (
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try{
      await storage.ref('test/$fileName').putFile(file);
    }on firebase_core.FirebaseException catch (e){
      print(fileName);
      print(filePath);
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('test').listAll();
    return results;
  }

  Future<String> DownloadURL(String inameName) async {
    String downloadURL = await storage.ref('test/$inameName').getDownloadURL();
    return downloadURL;
  }

}