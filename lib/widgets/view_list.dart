import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/pages/note_page.dart';

import '../helpers/db_helper.dart';
import '../providers/notes_provider.dart';

class ViewList extends StatelessWidget {
  NotesProvider provider; // Instance of NotesProvider to access notes data
  ViewList(this.provider);
  DBHelper dbHelper = DBHelper(); // Instance of DBHelper to interact with the database

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme; // Getting the current color scheme
    var reversedData = provider.arrData.reversed.toList(); // Reversing the data list to show latest notes first

    return ListView.builder(
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
                margin: EdgeInsets.only(bottom: defaultPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultPadding / 2),
                  color: colorScheme.primary,
                ),
                child: ListTile(
                  textColor: colorScheme.onPrimary,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding / 4),
                    child: Text(
                      reversedData[index][dbHelper.columnContent]!, // Displaying the note content
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle14(color: colorScheme.onPrimary),
                    ),
                  ),
                  subtitle: Text(
                    reversedData[index][dbHelper.columnDateTime]!, // Displaying the note date and time
                    style: textStyle12(
                            color: colorScheme.secondary.withOpacity(.7))
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
        itemCount: provider.arrData.length); // Number of items in the list
  }
}
