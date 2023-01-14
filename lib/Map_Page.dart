import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:view_tri/Pop_up/pop_up_widget.dart';
import 'package:view_tri/Utils/SearchBar.dart';
import 'package:view_tri/Utils/functions.dart';
import 'Utils/constants.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/emplacement.dart';

class Map_Page extends StatefulWidget {
  const Map_Page({Key? key}) : super(key: key);

  @override
  State<Map_Page> createState() => _Map_PageState();
}

class _Map_PageState extends State<Map_Page> {
  Set<Marker> markers = {};
  late GoogleMapController _controller;
  late PageController _pageController;
  final BitmapDescriptor icon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);

  void init_marker() {
    emplacementList.forEach((element) {
      markers.add(
        Marker(
            markerId: MarkerId(element.auteur),
            draggable: false,
            infoWindow:
                InfoWindow(title: element.auteur, snippet: element.adresse),
            position: element.location),
      );
    });
  }

  int prevPage = 0;

  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/homePage');
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
    init_marker();
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: emplacementList[_pageController.page!.toInt()].location,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          emplacementList[index].photo),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  emplacementList[index].auteur,
                                  style: const TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  emplacementList[index].adresse,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    emplacementList[index].description,
                                    style: const TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

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
                  Align(
                    alignment: Alignment(0, 1),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                      child: Text(
                        "Map",
                        style: GoogleFonts.raleway(textStyle: kHeadline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: mapCreated,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    mapType: MapType.hybrid,
                    markers: markers,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(49.09890103440097, -0.5033599129422207),
                      zoom: 6,
                    ),
                  ),
                  pop_window(
                    b: 300,
                    r: 10,
                  ),
                  Positioned(
                    bottom: 20.0,
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: emplacementList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeShopList(index);
                        },
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
