import 'package:flutter/material.dart';

const Color kAlexandriaGreen = Color(0xFF37C534);
const InputDecoration kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFE5FFE4),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const List<Shadow> kTextElevation = [
  Shadow(offset: Offset(0.0, 2.0), blurRadius: 5.0, color: Colors.grey),
];
