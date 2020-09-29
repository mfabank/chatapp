import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  final String currentUserId;
  HomePage({Key key, @required this.currentUserId}) : super(key:key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(onPressed: logoutUser,icon: Icon(Icons.close),label: Text("Çıkış Yap"),
    );
  }
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<Null>logoutUser() async{
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyApp()),(Route<dynamic> route) =>false);
  }
}


class UserResult extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

  }

}
