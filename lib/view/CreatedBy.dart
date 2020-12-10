import 'package:flutter/material.dart';
import 'package:projectuasmobilekelompok6/view/home_screen.dart';

class CreatedBy extends StatefulWidget {
  @override
  _CreatedByState createState() => _CreatedByState();
}

class _CreatedByState extends State<CreatedBy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Member Application'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 80.0),
              child: Text('Nama Kelompok : 7MSI1 '
                  'Anggota Kelompok : '
                  '31170068 - Jovita Sutanto '
                  '31170013 - Yoshua Bryant Winata '
                  '31170009 - Kevin Fernando '
                  'Kelas : 5MTI1A', style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w700),textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }
}
