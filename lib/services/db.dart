import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/////////////////// firestore  DataBase

class DBServices {
// Adding New task TO firestore

  Future<DocumentReference> addTask(
    String title,
    String description,
  ) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('myTasks')
        .doc('all')
        .collection(uid);
    Future<DocumentReference> grp = mycollection
        .add({'title': title, 'description': description, 'done': false});

    return grp;
  }

//////////////////////////////   check & uncheck task

  Future checkToggle(String docId, bool b) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('myTasks')
        .doc('all')
        .collection(uid);

    await mycollection.doc(docId).update({'done': b});
  }

// remove a Task

  Future removeTask(String docId) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('myTasks')
        .doc('all')
        .collection(uid);

    await mycollection.doc(docId).delete();
  }

  // //////////////////////////////////////////////////////////////////////////////////////////////////////////// new Shared

  /////////////////  add task group  to user groups (to the id of curren users)

  addUserGroups(String taskID, String groupName) {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('userGroups')
        .doc(uid)
        .collection('groups');

    return mycollection.doc(taskID).set({'name': groupName});
  }

////////////////////////////////////// create a new tasks group

  createNewGroup(String groupName) {
    //var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection =
        FirebaseFirestore.instance.collection('groups');

    return mycollection
        .add({}).then((value) => addUserGroups(value.id, groupName));
  }

///////////////////////// remove group

  removeGroup(String docID) {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('userGroups')
        .doc(uid)
        .collection('groups');

    mycollection.doc(docID).delete();
  }

  ///// add a task to a group

  addSharedTask(String title, String description, String groupID) {
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('groups')
        .doc(groupID)
        .collection('tasks');
    return mycollection
        .add({'title': title, 'description': description, 'done': false});
  }

  /////// remove one task from spicific group

  Future removeFromShared(String docId, String groupID) async {
    // var uid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('groups')
        .doc(groupID)
        .collection('tasks');

    await mycollection.doc(docId).delete();
  }

  Future sharedCheckToggle(String docId, bool b, String groupID) async {
    final CollectionReference mycollection = FirebaseFirestore.instance
        .collection('groups')
        .doc(groupID)
        .collection('tasks');

    await mycollection.doc(docId).update({'done': b});
  }
}
