import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {

        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff1e2a54),
                    Color(0xff1773b3),
                  ],
                ),
              ),
            ),
//            Positioned(
//              child: Image.asset(
//                'assets/images/echo.png',
//                fit: BoxFit.fill,
//              ),
//              right: 0,
//              bottom: 0,
//            ),
            Positioned(
              child: Container(
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    model.currentClass.className,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Medium',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              top: 200,
              left: 16,
            ),
            Positioned(
              bottom: -40,
              left: 16,
              child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width - 32,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      spreadRadius: 2,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff4ede7b),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://source.unsplash.com/ZHvM3XIOHoE" ?? Icons.person_pin
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Wali Kelas',
                          style: TextStyle(
                            color: Color(0xff7a7a7a),
                            fontFamily: 'Medium',
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          model.currentClass.teacherClass,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Medium',
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}