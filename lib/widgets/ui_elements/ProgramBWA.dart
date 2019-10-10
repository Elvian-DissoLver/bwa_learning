import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgramBWA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Program Kami', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
          ),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: (){},
          ),
        ),
        Container(
          width: double.infinity,
          height: 120.0,
          padding: EdgeInsets.only(
              left: 8.0
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                height: 50.0,
                width: 250.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue,
                          Colors.blue[800],
                        ]
                    ),
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(20.0, 20.0),
                              bottomRight: Radius.elliptical(150.0, 150.0)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, left: 5.0, right: 30.0, bottom: 30.0),
                        child: Text(
                          '%',
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lihat Semua \nProgram',
                        style: TextStyle(fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
//              Container(
//                height: 150.0,
//                width: 300.0,
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadiusDirectional.circular(8.0),
//                    image: DecorationImage(
//                        image: AssetImage('images/promo.jpeg')
//                    )
//                ),
//                margin: EdgeInsets.only(left: 10.0),
//                child: null,
//              )
            ],
          ),
        )
      ],
    );
  }
}