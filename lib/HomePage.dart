import 'package:flutter/material.dart';
import 'package:view_tri/Reg/auth_methods.dart';
import 'package:view_tri/Utils/MainContainer.dart';
import 'package:view_tri/Utils/constants.dart';
import 'package:view_tri/Utils/functions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Utils/RoundedButton.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, '/map_page');
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void getUserName() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kOrange_main,
        onTap: _onItemTapped,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: kOrange_main4,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 40,
                    right: 10,
                    child: TextButton(
                        child: Text("Sign out", style: TextStyle(fontSize: 14)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          AuthMethods().signOut();
                          Navigator.of(context)
                              .pushReplacementNamed("/welcome_screen");
                        }),
                  ),
                  Align(
                    alignment: Alignment(0, 1),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                      child: Text(
                        "TripView",
                        style: GoogleFonts.raleway(textStyle: kHeadline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
            thickness: 2,
            height: 0,
            color: Colors.black,
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RoundedButton(
                            colour: Colors.white,
                            title: "Mexique",
                            coleurText: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RoundedButton(
                            colour: Colors.white,
                            title: "France",
                            coleurText: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RoundedButton(
                            colour: Colors.white,
                            title: "Suède",
                            coleurText: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Text(
                        "Vos Trips",
                        style: GoogleFonts.raleway(textStyle: kHeadline5),
                      ),
                      MainContainer(
                          text: "", route: "/map_page", snacktext: "Oulou"),
                      Text(
                        "Découvrez ",
                        style: GoogleFonts.raleway(textStyle: kHeadline5),
                      ),
                      MainContainer(
                          text: "", route: "route", snacktext: "Oulou"),
                      Text(
                        "Nouveau trip",
                        style: GoogleFonts.raleway(textStyle: kHeadline5),
                      ),
                      MainContainer(
                          text: "", route: "route", snacktext: "Oulou"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
