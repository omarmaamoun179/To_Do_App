import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FireBaseFunctions {
  static CollectionReference<TaskModel> getColletions() {
    return FirebaseFirestore.instance
        .collection(TaskModel.cololectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFireStore(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toFireStore(),
        );
  }

  static Future<void> addTasks(TaskModel task) {
    var collection = getColletions();
    var docu = collection.doc();
    task.id = docu.id;
    return docu.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    return getColletions()
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    return getColletions().doc(taskModel.id).update(taskModel.toFireStore());
  }

  static Future<void> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }catch(e){
      print(e);
    }
  }

  static Future<void> singup(
      String email, String password, int age, String name) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      USerModel userModel = USerModel(
          name: name, age: age, email: email, id: credential.user!.uid);
      var collection = getUsersColletions();
      var docRef = collection.doc(credential.user!.uid);
      docRef.set(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static CollectionReference<USerModel> getUsersColletions() {
    return FirebaseFirestore.instance
        .collection(USerModel.userCollectionName)
        .withConverter<USerModel>(
          fromFirestore: (snapshot, _) =>
              USerModel.fromFireStore(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toFirestore(),
        );
  }
static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }


  
  static Future<List<TaskModel>> getAllTasks() async{
    var collection = getColletions().get();
   var data = collection.then((value) =>value.docs.map((e) =>e.data()).toList());
   
    return data;
  }
}
