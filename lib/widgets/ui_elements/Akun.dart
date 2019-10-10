import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Akun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://source.unsplash.com/ZHvM3XIOHoE"
                  )
              ),
          ),
        ),
        title: Text('Muhammad Sulaiman', style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Admin', style: TextStyle(fontWeight: FontWeight.bold),
        ),

      ),
    );
  }
}