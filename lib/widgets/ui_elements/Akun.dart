import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:bwa_learning/scoped_models/talim/AppModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Akun extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModelV2>(
        builder: (BuildContext context, Widget child, AppModelV2 model) {
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
              title: Text(model.currentUser.userName, style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(model.currentUser.status, style: TextStyle(fontWeight: FontWeight.bold),
              ),

            ),
          );
        }
    );

  }
}