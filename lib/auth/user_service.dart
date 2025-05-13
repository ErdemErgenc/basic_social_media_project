import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_procet/auth/user_model.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //create user

  Future<void> createUser(UserModel) async {
    try {
     await firestore.collection("users").doc(UserModel.uid).set(UserModel.toJson());
    } catch (e) {
      print("Kullanıcı oluşturma hatası $e");
    }
  }

}