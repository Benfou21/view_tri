import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:view_tri/Utils/RoundedButton.dart';

import 'package:view_tri/Utils/constants.dart';

import 'package:dialogs/dialogs.dart';
import 'package:view_tri/Utils/functions.dart';
import 'package:widget_mask/widget_mask.dart';

import 'auth_methods.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String pseudo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 0.9],
              colors: [kOrange_main4, kOrange_main3]),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: WidgetMask(
                    blendMode: BlendMode.srcATop,
                    childSaveLayer: true,
                    mask: Image.asset(
                      "images/image1.jpg",
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Image.asset(
                      "images/ovale2.png",
                      scale: 1.7,
                    ),
                  ),
                ),
              ),
              addVerticalSpace(48),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                style: const TextStyle(color: Colors.black),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Entrer votre email"),
              ),
              addVerticalSpace(8),
              TextField(
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pseudo = value;
                },
                style: const TextStyle(color: Colors.black),
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Entrer votre pseudo"),
              ),
              addVerticalSpace(8),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Entrer votre mot de passe")),
              addVerticalSpace(24),
              RoundedButton(
                coleurText: Colors.white,
                title: "Register",
                colour: Colors.black,
                onPressed: () async {
                  try {
                    String res = await AuthMethods().signUpUser(
                        email: email, password: password, username: pseudo);
                    if (res == "success") {
                      Navigator.popAndPushNamed(context, '/homePage');
                    } else {
                      MessageDialog message = MessageDialog(
                        message: "Veuillez remplir tous les champs",
                        title: "Champs non remplis",
                      );
                      message.show(context);
                    }
                  } catch (e) {
                    print(e);
                    MessageDialog message = MessageDialog(
                      message: e.toString(),
                      title: "Error",
                    );
                    message.show(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
