import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/////////////////// firestore  DataBase

class DBServices {
// Adding New Custumer TO firestore

  Future addTask(
    String title,
    String description,
  ) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('users')
        .doc('all')
        .collection(uid);
    await mycollection
        .add({'title': title, 'description': description, 'done': false});
  }

////////////////////////////// update the check

  Future update(String docId) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('users')
        .doc('all')
        .collection(uid);

    await mycollection.doc(docId).update({'done': true});
  }

  ////////////////////////////////// uncheck

  Future unCkeck(String docId) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('users')
        .doc('all')
        .collection(uid);

    await mycollection.doc(docId).update({'done': false});
  }

// remove a Task

  Future removeTask(String docId) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('users')
        .doc('all')
        .collection(uid);

    await mycollection.doc(docId).delete();
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////  adding shared users

  Future addShared(
      String title, String description, String selectedCollection) async {
    // var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('shared')
        .doc('all')
        .collection(selectedCollection);
    await mycollection
        .add({'title': title, 'description': description, 'done': false});
  }

////////////////////////////////////////// remove Shared
  ///
  Future removeShared(String docId, String currentId) async {
    // var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('shared')
        .doc('all')
        .collection(currentId);

    await mycollection.doc(docId).delete();
  }

/////////////////////////////////////////// check Shared
  ///
  Future updateShared(String docId, String currentId) async {
    // var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('shared')
        .doc('all')
        .collection(currentId);

    await mycollection.doc(docId).update({'done': true});
  }
  ////////////////////////////////////////// unCkeck Shared

  Future unCheckShared(String docId, String currentId) async {
    // var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('shared')
        .doc('all')
        .collection(currentId);

    await mycollection.doc(docId).update({'done': false});
  }
}
