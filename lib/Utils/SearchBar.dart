import 'constants.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({required this.text});

  late String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.black),
            decoration: kTextFieldDecoration.copyWith(hintText: text),
          ),
        ),
        Expanded(
          child: Icon(
            Icons.search,
            size: 40,
          ),
        ),
      ],
    );
  }
}
