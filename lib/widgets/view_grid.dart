import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/pages/note_page.dart';

import '../helpers/db_helper.dart';
import '../providers/notes_provider.dart';

class ViewGrid extends StatelessWidget {
  NotesProvider provider; // Instance of NotesProvider to access notes data
  ViewGrid(this.provider);
  DBHelper dbHelper = DBHelper(); // Instance of DBHelper to interact with the database

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme; // Getting the current color scheme
    var reversedData = provider.arrData.reversed.toList(); // Reversing the data list to show latest notes first

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: defaultPadding / 2,
        mainAxisSpacing: defaultPadding / 2,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotePage(
                  columnId: reversedData[index][dbHelper.columnId], // Passing the note ID
                  dateTime: reversedData[index][dbHelper.columnDateTime]!, // Passing the note date and time
                  content: reversedData[index][dbHelper.columnContent]!, // Passing the note content
                ),
              ));
        },
        child: Container(
          padding: EdgeInsets.all(defaultPadding / 1.2), // Padding inside the grid item
          decoration: BoxDecoration(
            color: colorScheme.primary, // Background color of the grid item
            borderRadius: BorderRadius.circular(defaultPadding / 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reversedData[index][dbHelper.columnContent]!, // Displaying the note content
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: textStyle14(color: colorScheme.onPrimary), // Custom text style
              ),
              Text(
                reversedData[index][dbHelper.columnDateTime]!, // Displaying the note date and time
                style: textStyle12(color: colorScheme.secondary.withOpacity(.7))
                    .copyWith(fontWeight: FontWeight.w700), // Custom text style with opacity
              ),
            ],
          ),
        ),
      ),
      itemCount: provider.arrData.length, // Number of items in the grid
    );
  }
}
