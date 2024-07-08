import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/pages/note_page.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../main.dart';
import '../providers/notes_provider.dart';
import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';
import '../widgets/view_grid.dart';
import '../widgets/view_list.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isListView = false; // Variable to toggle between list and grid view
  bool isDark = false; // Variable to toggle between dark and light theme

  @override
  void initState() {
    context.read<NotesProvider>().fetchNotes(); // Fetching notes when the widget initializes
    super.initState();
  }

  // Method to get the current formatted date
  String getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('MMM dd, yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme; // Getting the current color scheme
    return Scaffold(
      backgroundColor: colorScheme.background, // Setting the background color
      appBar: AppBar(
        title: Text(
          'My Notes',
          style: textStyle20(color: colorScheme.onPrimary), // Custom text style for the title
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: colorScheme.onPrimary,
            ),
            color: colorScheme.primary,
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    isDark = !isDark; // Toggling the theme
                    if (isDark) {
                      MyApp.of(context)!.changeTheme(darkTheme); // Setting the dark theme
                    } else {
                      MyApp.of(context)!.changeTheme(lightTheme); // Setting the light theme
                    }
                    setState(() {}); // Rebuilding the widget with the new theme
                  },
                  child: Row(
                    children: [
                      Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode, // Icon based on the current theme
                        color: colorScheme.onPrimary,
                      ),
                      SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(
                        isDark ? 'Light Mode' : 'Dark Mode', // Text based on the current theme
                        style: textStyle14(color: colorScheme.onPrimary),
                      )
                    ],
                  )),
              PopupMenuItem(
                  onTap: () {
                    isListView = !isListView; // Toggling the view mode
                    setState(() {}); // Rebuilding the widget with the new view mode
                  },
                  child: Row(
                    children: [
                      Icon(
                        isListView ? Icons.grid_view_rounded : Icons.table_rows_rounded, // Icon based on the current view mode
                        color: colorScheme.onPrimary,
                      ),
                      SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(isListView ? 'Grid View' : 'List View', // Text based on the current view mode
                          style: textStyle14(color: colorScheme.onPrimary)),
                    ],
                  )),
            ],
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: defaultPadding,
          right: defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding / 1.25),
              child: Text(
                'total: ${context.watch<NotesProvider>().arrData.length} notes found', // Displaying the total number of notes
                style: textStyle12(color: colorScheme.secondary).copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Consumer<NotesProvider>(
                builder: (_, provider, __) {
                  if (provider.arrData.isNotEmpty) {
                    return isListView ? ViewList(provider) : ViewGrid(provider); // Displaying notes in list or grid view based on isListView
                  } else {
                    return Center(
                      child: Text(
                        'No notes available. Tap + to add a new note', // Message when no notes are available
                        style: textStyle14(color: colorScheme.onPrimary.withOpacity(.7)),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotePage(dateTime: getFormattedDate()), // Navigating to the NotePage with the current date
              ));
        },
        elevation: 11,
        backgroundColor: colorScheme.secondary,
        child: Icon(
          Icons.add,
          size: 32,
          color: colorScheme.onBackground,
        ),
      ),
    );
  }
}
