import 'package:cloud_firestore/cloud_firestore.dart';
class User {
  final String id;
  final String nickname;
  final String photoUrl;
  final String createAt;

  User({
    this.id,
    this.nickname,
    this.photoUrl,
    this.createAt,
});
  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      id: doc.documentID,
      photoUrl: doc.data()["photoUrl"],
      nickname: doc.data()["nickname"],
      createAt: doc.data()["createdAt"],

    );
  }

}
