import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final Icon icon;
  final Function onPressed;
  final Color color;

  RoundedButton({
    this.icon,
    @required this.label,
    @required this.onPressed,
    @required this.color,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      child: this.icon != null
          ? FlatButton.icon(
        color: color,
        icon: icon,
        label: Text(label),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        onPressed: onPressed,
      )
          : FlatButton(
        color: color,
        child: Text(label),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
