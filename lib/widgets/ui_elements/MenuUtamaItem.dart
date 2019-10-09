import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuUtamaItem extends StatelessWidget {
  MenuUtamaItem({this.title, this.icon, this.colorBox, this.iconColor, this.onPressed});
  final String title;
  final IconData icon;
  final Color colorBox,iconColor;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
                color: colorBox,
                shape: BoxShape.circle
            ),
            child: RawMaterialButton(
              shape: CircleBorder(),
              onPressed: onPressed,
              child: Icon(icon, color: iconColor,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(title, style: TextStyle(fontSize: 12.0, ), textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}