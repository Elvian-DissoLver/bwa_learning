import 'package:bwa_learning/pages/admin/beranda/Beranda.dart';
import 'package:bwa_learning/pages/admin/daftar_kelas/DaftarKelas.dart';
import 'package:bwa_learning/pages/pesanan.dart';
import 'package:bwa_learning/pages/simpan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MenuUtamaItem.dart';

class MenuUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      children: <Widget>[
        MenuUtamaItem(
            title: 'Daftar Kelas',
            icon: Icons.class_,
            colorBox: Colors.blue,
            iconColor: Colors.white,
            onPressed: () => Navigator.pushNamed(context, '/daftarKelas')
        ),
        MenuUtamaItem(
            title: 'Daftar Guru',
            icon: (FontAwesomeIcons.chalkboardTeacher),
            colorBox: Colors.blue[900],
            iconColor: Colors.white,
            onPressed: () {}
        ),
        MenuUtamaItem(
            title: 'Daftar Murid',
            icon: Icons.person_pin,
            colorBox: Colors.purple,
            iconColor: Colors.white,
            onPressed: () {}
        ),
      ],
    );
  }
}
List<MenuUtamaItem> menuUtamaItem = [
  MenuUtamaItem(
    title: 'Tiket Pesawat',
    icon: Icons.flight,
    colorBox: Colors.blue,
    iconColor: Colors.white,
    onPressed: () => print('loop')
  ),
  MenuUtamaItem(
    title: 'Hotel',
    icon: Icons.hotel,
    colorBox: Colors.blue[900],
    iconColor: Colors.white,
    onPressed: () =>
      Pesanan(),
  ),
  MenuUtamaItem(
    title: 'Pesawat + Hotel',
    icon: Icons.flight_land,
    colorBox: Colors.purple,
    iconColor: Colors.white,
  ),
  MenuUtamaItem(
    title: 'Al - Quran',
    icon:(FontAwesomeIcons.quran),
    colorBox: Colors.green[300],
    iconColor: Colors.white,
  ),
  MenuUtamaItem(
    title: 'Kuliner',
    icon: Icons.local_dining,
    colorBox: Colors.orange,
    iconColor: Colors.white,
  ),
  MenuUtamaItem(
    title: 'Tiket Kereta Api',
    icon: Icons.train,
    colorBox: Colors.orange[300],
    iconColor: Colors.white,
  ),
  MenuUtamaItem(
    title: 'Tiket Bus & Travel',
    icon: Icons.directions_bus,
    colorBox: Colors.green,
    iconColor: Colors.white,
  ),
  MenuUtamaItem(
    title: 'Transportasi Bandara',
    icon: Icons.local_taxi,
    colorBox: Colors.blue [300],
    iconColor: Colors.white,
  ),
  MenuUtamaItem(
    title: 'Rental Mobil',
    icon: Icons.directions_car,
    colorBox: Colors.green[900],
    iconColor: Colors.white,
  ),
  MenuUtamaItem(
    title: 'Semua Produk',
    icon: Icons.blur_on,
    colorBox: Colors.grey,
    iconColor: Colors.black,
  ),
];