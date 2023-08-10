// ignore_for_file: unused_import

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart' as model;
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // sign up the user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async{
    String res = "Some error ocurred";
    try {
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty ){
        //registrar el usuario
       UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

       print(cred.user!.uid);

       String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        //add user a la base de datos

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio:bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
         );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //loggin user
  Future<String> loginUser({
    required String email,
    required String password
  }) async {
    String res = "Some error ocurred";

    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    }catch(err){
      res = err.toString();
    }
    return res;
  }
}