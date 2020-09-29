import 'package:chatapp/animations/progressbar.dart';
import 'package:chatapp/pages/homepage.dart';
import 'package:chatapp/pages/registerpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgotpassword.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool isLoggedIn = false;
  bool isLoading = false;
  FirebaseUser currentUser;





  @override
  void initState() {

    super.initState();


    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoggedIn = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(currentUserId: preferences.get("id"))));
    }
    this.setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffeee8aa), Color(0xff79cdcd)],
              begin: FractionalOffset(0.3, 1),
            ),
          ),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Flexible(
                  child: Container(
                      height: 200,
                      width: 200,
                      child: Image.network(
                          "https://images.vexels.com/media/users/3/136808/isolated/preview/d3455a22af5f3ed7565fb5fb71bb8d43-send-message-icon-by-vexels.png")),
                ),
                Container(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Flexible(
                    child: Form(
                      child: Column(
                        children: [
                          Container(
                            width: 275,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email",
                                hintText: "example@example.com",
                                isDense: true,
                              ),
                            ),
                          ),
                          Container(
                            width: 275,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Parola",
                                hintText: "******",
                                isDense: true,
                              ),
                            ),
                          ),
                          SizedBox(height: 1),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 185),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: Text(
                                  "Şifremi Unuttum",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          180,
                        ),
                        side: BorderSide(color: Colors.white)),
                    color: Colors.amberAccent[100],
                    child: Text(
                      "Giriş Yap",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          180,
                        ),
                        side: BorderSide(color: Colors.white)),
                    color: Colors.green,
                    child: Text(
                      "Google ile Giriş Yap",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      controlSignIn();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: isLoading ? circularProgress() : Container(),
                ),
                SizedBox(
                  height: 50,
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Üye değil misiniz ?",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            "Hemen Ol !",
                            style: TextStyle(
                                color: Colors.amberAccent, fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<Null> controlSignIn() async {
    preferences = await SharedPreferences.getInstance();
    this.setState(() {
      isLoading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuthentication =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuthentication.accessToken);
    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    if (firebaseUser != null) {
      final QuerySnapshot resultQuery = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documentSnapshots = resultQuery.documents;
      if (documentSnapshots.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          "nickname": firebaseUser.displayName,
          "photoURL:": firebaseUser.photoUrl,
          "id": firebaseUser.uid,
          "aboutMe": "Çevrimiçi",
          "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
          "chattingWith": null,
        });
        currentUser = firebaseUser;
        await preferences.setString("id", currentUser.uid);
        await preferences.setString("nickname", currentUser.displayName);
        await preferences.setString("photoUrl", currentUser.photoUrl);
      } else {
        currentUser = firebaseUser;
        await preferences.setString("id", documentSnapshots[0].data()["id "]);
        await preferences.setString(
            "nickname", documentSnapshots[0].data()["nickname"]);
        await preferences.setString(
            "photoUrl", documentSnapshots[0].data()["photoUrl"]);
        await preferences.setString("aboutMe", documentSnapshots[0].data()["aboutMe"]);
      }
      Fluttertoast.showToast(msg: "Tebrikler, Giriş Başarılı.");
      this.setState(() {
        isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(currentUserId: firebaseUser.uid)));
    } else {
      Fluttertoast.showToast(msg: "Başarısız, Tekrar deneyin.");
      this.setState(() {
        isLoading = false;
      });
    }
  }
}
