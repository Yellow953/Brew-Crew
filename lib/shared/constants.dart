import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  icon: Icon(
    Icons.password,
    color: Colors.brown,
  ),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.brown,
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 1,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);