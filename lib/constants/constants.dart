import 'package:flutter/material.dart';

const defaultPadding = 16.0; // Default padding value used throughout the app

// Function to create a TextStyle with font size 12
TextStyle textStyle12({required Color color}) {
  return TextStyle(
    color: color,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
  );
}

// Function to create a TextStyle with font size 14
TextStyle textStyle14({required Color color}) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins',
  );
}

// Function to create a TextStyle with font size 20
TextStyle textStyle20({required Color color}) {
  return TextStyle(
    color: color,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins',
  );
}
