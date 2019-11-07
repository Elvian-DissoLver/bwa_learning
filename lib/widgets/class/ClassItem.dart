import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassItem extends StatelessWidget {
  ClassItem({this.title, this.icon, this.colorBox, this.iconColor, this.onPressed});
  final String title;
  final IconData icon;
  final Color colorBox,iconColor;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            height: 60.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: colorBox,
              shape: BoxShape.circle,
            ),
            child: RawMaterialButton(
              shape: CircleBorder(),
              onPressed: onPressed,
              child: Text(title, style: TextStyle(fontSize: 11.0, ), textAlign: TextAlign.center,),
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.only(top: 2.0),
//            child: Text(title, style: TextStyle(fontSize: 11.0, ), textAlign: TextAlign.center,),
//          )
        ],
    );
  }
}