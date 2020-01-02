import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String fileName;
  final double left;
  final VoidCallback onPressedNext;


  CourseCard({@required this.fileName, this.left,this.onPressedNext});

  @override
  Widget build(BuildContext context) {
    Widget fileNameWidget = Text(fileName.trim().length <= 20 ? fileName.trim() : fileName.trim().substring(0, 20) + '...');

    Icon fileIcon = Icon(Icons.insert_drive_file);

    IconButton expandButton = IconButton(
      icon: Icon(Icons.navigate_next),
      onPressed: onPressedNext,
    );

    return Container(
      margin: EdgeInsets.fromLTRB(left, 5, 5, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    child: ListTile(
        leading: fileIcon,
        title: fileNameWidget,
        trailing: expandButton,
      ),
    );
  }
}