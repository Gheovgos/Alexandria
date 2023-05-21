import 'package:flutter/material.dart';

const Color kAlexandriaGreen = Color(0xFF37C534);
const InputDecoration kInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    fontSize: 15,
    shadows: [
      Shadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.grey),
    ],
  ),
  filled: true,
  fillColor: Color(0xFFE5FFE4),
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0),
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
