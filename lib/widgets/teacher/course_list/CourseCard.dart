import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CourseCard extends StatelessWidget {
  final String fileName;
  final double left;
  final VoidCallback onPressedNext;
  final Function onPressed;

  CourseCard({@required this.fileName, this.left,this.onPressedNext, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Widget fileNameWidget = Text(fileName.trim().length <= 20 ? fileName.trim() : fileName.trim().substring(0, 20) + '...');

    Icon fileIcon = Icon(Icons.insert_drive_file);

    IconButton expandButton = IconButton(
      icon: Icon(Icons.remove_red_eye),
      onPressed: onPressed,
    );

    return Slidable(
      delegate: new SlidableBehindDelegate(),
      actionExtentRatio: 0.25,
      child: Container(
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
      ),
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}