import 'package:flutter/material.dart';
import 'package:projectuasmobilekelompok6/view/home_screen.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('About Apps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 80.0),
              child: Text('Money App adalah aplikasi yang digunakan untuk memanajemen pencatatan pengeluaran serta pemasukan dari keuangan yang dimiliki oleh seseorang berdasarkan kategori IN dan OUT', style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.w600),textAlign: TextAlign.center)
      ),
      ]
        ),
      ),
    );
  }
}
