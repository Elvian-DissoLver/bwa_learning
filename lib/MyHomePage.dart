import 'package:bwa_learning/pages/beranda/Beranda.dart';
import 'package:bwa_learning/pages/inbox.dart';
import 'package:bwa_learning/pages/pesanan.dart';
import 'package:bwa_learning/pages/profile.dart';
import 'package:bwa_learning/pages/simpan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _seletedIndex = 0;
  final _layoutPage = [
    Beranda(),
    Simpan(),
    Pesanan(),
    Inbox(),
    Profile()
  ];

  void _onTabItem(int index){
    setState(() {
      _seletedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutPage.elementAt(_seletedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.save),
              title: Text('Simpan')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda),
              title: Text('Pesanan')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              title: Text('Inbox')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Akun Saya')
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _seletedIndex,
        onTap: _onTabItem,
      ),
    );
  }
}