import 'package:flutter/material.dart';

const Color kAlexandriaGreen = Color(0xFF37C534);
const Color kInfoBoxColor = Color(0xFFF9ECEC);
const Color kTextBoxColor = Color(0xFFE5FFE4);
const InputDecoration kInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    fontSize: 15,
    shadows: [
      Shadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.grey),
    ],
  ),
  filled: true,
  fillColor: kTextBoxColor,
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0),
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
);

const List<Shadow> kTextElevation = [
  Shadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.grey),
];
const double kButtonElevation = 5;
