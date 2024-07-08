import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/notes_provider.dart';

class NotePage extends StatefulWidget {
  int? columnId; // ID of the note column (null if new note)
  String dateTime; // Date and time of the note
  String? content; // Content of the note

  late TextEditingController contentController; // Text editing controller for the note content

  NotePage({
    this.columnId,
    required this.dateTime,
    this.content,
  }) : contentController = TextEditingController(text: content); // Initializing the text controller with the content

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme; // Getting the current color scheme
    return Scaffold(
      backgroundColor: colorScheme.background, // Setting the background color
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context), // Navigating back to the previous screen
          child: Icon(
            Icons.arrow_back,
            color: colorScheme.onPrimary,
          ),
        ),
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
                    context.read<NotesProvider>().deleteNote(widget.columnId!); // Deleting the note
                    Navigator.pop(context); // Navigating back to the previous screen
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: colorScheme.onPrimary,
                      ),
                      SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(
                        'Delete',
                        style: textStyle14(color: colorScheme.onPrimary),
                      )
                    ],
                  )),
              PopupMenuItem(
                  onTap: () {
                    widget.columnId != null
                        ? context.read<NotesProvider>().updateNote(
                            widget.columnId!,
                            widget.dateTime,
                            widget.content ?? '') // Updating the note if it exists
                        : context
                            .read<NotesProvider>()
                            .addNote(widget.dateTime, widget.content ?? ''); // Adding a new note if it doesn't exist
                    Navigator.pop(context); // Navigating back to the previous screen
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: colorScheme.onPrimary,
                      ),
                      SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text('Save',
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
            Text(
              '${widget.dateTime} | ${widget.contentController.text.length.toString()} characters', // Displaying the date and character count
              style: textStyle12(color: colorScheme.secondary)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: TextField(
                controller: widget.contentController, // Setting the text controller
                cursorColor: colorScheme.onPrimary,
                onChanged: (value) {
                  setState(() {
                    widget.content = value; // Updating the content as the user types
                  });
                },
                maxLines: null, // Allowing multiple lines in the text field
                keyboardType: TextInputType.text,
                style: textStyle14(color: colorScheme.onPrimary),
                decoration: InputDecoration(
                  hintText: "What's in your mind today...", // Placeholder text
                  hintStyle:
                      textStyle14(color: colorScheme.onPrimary.withOpacity(.5)),
                  border: InputBorder.none, // Removing the border
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
