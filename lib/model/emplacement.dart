import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Emplacement {
  late LatLng location;
  late String auteur;
  late String description;
  late String adresse;
  late String photo;
  late String ville;

  Emplacement(
      {required this.location,
      required this.auteur,
      required this.description,
      required this.adresse,
      required this.photo,
      required this.ville});
}

final List<Emplacement> emplacementList = [
  Emplacement(
      location: const LatLng(49.70656158847038, 0.19929924220670936),
      ville: "Etretat",
      auteur: "Jean",
      description: "40m*60m",
      adresse: "13 bis rue du manoir",
      photo: 'images/image1.jpg'),
  Emplacement(
      ville: "Etretat",
      location: const LatLng(49.7039526934604, 0.19260444894289605),
      auteur: "Sis",
      description: "40m*60m",
      adresse: "20 rue des Lilas",
      photo: 'images/image2.jpg'),
  Emplacement(
      ville: "Lille",
      location: const LatLng(50.59866116101507, 3.0330490812040867),
      auteur: "Pat",
      description: "40m*60m",
      adresse: "20 rue des Lilas",
      photo: 'images/image1.jpg'),
  Emplacement(
      ville: "Tourcoing",
      location: const LatLng(50.71370006872522, 3.1652780074014353),
      auteur: "Kiki",
      description: "40m*60m",
      adresse: "20 rue des Lilas",
      photo: 'images/image2.jpg'),
  Emplacement(
      ville: "Anzin",
      location: const LatLng(50.37601997982865, 3.5210160534981294),
      auteur: "Lolo",
      description: "40m*60m",
      adresse: "20 rue des Lilas",
      photo: 'images/image2.jpg'),
];
