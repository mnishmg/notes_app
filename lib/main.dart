import 'package:flutter/material.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:notes/theme/light_theme.dart';
import 'pages/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NotesProvider(), // NotesProvider added
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  // Helper method to access the _MyAppState
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // Initial theme set to light theme
  ThemeData currentTheme = lightTheme;

  // Method to change the theme
  void changeTheme(ThemeData currentTheme) {
    this.currentTheme = currentTheme;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: currentTheme, // Setting the current theme
      home: MainPage(),
    );
  }
}
