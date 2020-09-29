import 'package:chatapp/pages/loginpage.dart';
import 'package:chatapp/pages/registerpage.dart';

import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffeee8aa), Color(0xff79cdcd)],
              begin: FractionalOffset(0.3, 1),
            ),
          ),
          child: Flexible(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Flexible(
                    child: Container(
                        height: 200,
                        width: 200,
                        child: Image.network(
                            "https://images.vexels.com/media/users/3/136808/isolated/preview/d3455a22af5f3ed7565fb5fb71bb8d43-send-message-icon-by-vexels.png")),
                  ),
                  Flexible(
                    child: Container(
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    child: Flexible(
                      child: Form(
                        child: Column(
                          children: [
                            Flexible(
                              child: Container(
                                width: 275,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "example@example.com",
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Flexible(
                              child: Text(
                                  "Şifre sıfırlama bağlantısı göndereceğiz."),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              180,
                            ),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.amberAccent[100],
                        child: Text(
                          "Gönder",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Container(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Giriş Ekranı",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
