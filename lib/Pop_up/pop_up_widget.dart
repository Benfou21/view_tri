import 'package:image_picker/image_picker.dart';
import 'package:view_tri/Utils/Capsul.dart';
import 'package:view_tri/Utils/RoundedButton.dart';
import 'package:view_tri/Utils/constants.dart';

import 'dart:typed_data';

import '../Utils/utils.dart';
import 'hero_dialog_route.dart';

import 'package:flutter/material.dart';

class pop_window extends StatelessWidget {
  double b;
  double r;
  double? l;
  double? t;
  pop_window({required this.b, required this.r, this.l, this.t});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: b,
      right: r,
      left: l,
      top: t,
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return popInfo();
            }));
          },
          child: Hero(
            tag: 'info',
            child: Container(
              decoration: const BoxDecoration(
                  color: kOrange_main3, shape: BoxShape.circle),
              child: const Icon(
                Icons.travel_explore_outlined, //add_to_photos_outlined
                size: 56,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var activities = <Widget>[];

class popInfo extends StatefulWidget {
  const popInfo({Key? key}) : super(key: key);

  @override
  State<popInfo> createState() => _popInfoState();
}

class _popInfoState extends State<popInfo> {
  List<Widget> steps = [];

  @override
  initState() {
    steps.add(
      Expanded(
        child: RoundedButton(
          title: "1",
          colour: Colors.amber,
          onPressed: () {},
          coleurText: Colors.black,
        ),
      ),
    );
    steps.add(
      Expanded(
        child: RoundedButton(
          title: "1",
          colour: Colors.amber,
          onPressed: () {},
          coleurText: Colors.black,
        ),
      ),
    );
    steps.add(
      Expanded(
        child: RoundedButton(
          title: "1",
          colour: Colors.amber,
          onPressed: () {},
          coleurText: Colors.black,
        ),
      ),
    );
    steps.add(
      Expanded(
        child: RoundedButton(
          title: "1",
          colour: Colors.amber,
          onPressed: () {},
          coleurText: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Hero(
          tag: 'info',
          child: Container(
            decoration: BoxDecoration(
                color: kOrange_main3, borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.fromLTRB(20, 150, 20, 150),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Capsul(
                      text: "Activités",
                      onpressed: () async {
                        Uint8List im = await pickImage(ImageSource.gallery);
                        setState(() {
                          activities.add(buildCard("Visite à Etretat",
                              'Etretat', 'A faire de tous temps', im));
                          activities.add(const Divider(
                            color: Colors.white,
                            thickness: 0.2,
                          ));
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView(
                        reverse: false,

                        //mainAxisSize: MainAxisSize.min,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: activities),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Card buildCard(
    String titre, String sousTitre, String descriptionn, Uint8List image) {
  // set state because we need to display the image we selected on the circle avatar

  var sousTitre = 'Etretat';

  var description = 'A faire de tous temps';
  return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(titre),
            subtitle: Text(sousTitre),
            trailing: Icon(Icons.favorite_outline),
          ),
          Container(
              height: 200.0,
              child: Ink.image(
                image: MemoryImage(image),
                fit: BoxFit.cover,
              )),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(description),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('LEARN MORE'),
                onPressed: () {/* ... */},
              )
            ],
          )
        ],
      ));
}
