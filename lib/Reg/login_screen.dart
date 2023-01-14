import 'package:flutter/material.dart';

import 'package:dialogs/dialogs.dart';
import 'package:view_tri/Reg/auth_methods.dart';

import 'package:view_tri/Utils/constants.dart';

import 'package:view_tri/Utils/RoundedButton.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:view_tri/Utils/functions.dart';
import 'package:widget_mask/widget_mask.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  final _auth = FirebaseAuth.instance;
  late String email = "";
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      hintText: "Entrer votre email")),
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
                title: "Log in",
                colour: Colors.black,
                coleurText: Colors.white,
                onPressed: () async {
                  try {
                    String res = await AuthMethods()
                        .loginUser(email: email, password: password);
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
                      title: "Erreur",
                    );
                    message.show(context);
                  }
                  ;
                },
              ),
              addVerticalSpace(10),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      child: const Text("Réinitialiser le mot de passe"),
                      onTap: () {
                        RegExp exp = RegExp(
                          "\\b" + "@" + "\\b",
                          caseSensitive: true,
                        );
                        bool containe = exp.hasMatch(email);

                        if (email != "" && containe) {
                          resetPassword(email);
                          MessageDialog message = MessageDialog(
                            message: "Le mail de vérification a été envoyé ",
                            title: "Succès",
                          );
                          message.show(context);
                        } else {
                          MessageDialog message = MessageDialog(
                            message: "Veuillez rentrer un email valide ",
                            title: "Erreur",
                          );
                          message.show(context);
                        }
                      },
                    ),
                    addVerticalSpace(20),
                    GestureDetector(
                      child: const Text("Pas de compte ? Créez-en un"),
                      onTap: () {
                        Navigator.pushNamed(context, "/register");
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
