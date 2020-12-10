import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectuasmobilekelompok6/models/constant.dart';
import 'package:projectuasmobilekelompok6/services/sharedpreferences.dart';
import 'package:projectuasmobilekelompok6/view/addmoney_screen.dart';
import 'package:projectuasmobilekelompok6/view/editmoney_screen.dart';
import 'package:projectuasmobilekelompok6/view/login_screen.dart';
import 'package:projectuasmobilekelompok6/view/readmoney_screen.dart';
import 'package:http/http.dart' as http;
import 'package:projectuasmobilekelompok6/models/moneymodels.dart';
import 'dart:convert';
import 'package:projectuasmobilekelompok6/view/about.dart';

import 'CreatedBy.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String usernameAPI, idUser;
  var moneyList = List<MoneyModel>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _getPref();
    _getMoneyData();
  }

  _getPref() async {
    await SharedPref.getPref().then((value) {
      setState(() {
        if (value != null) {
          usernameAPI = value;
        } else {
          usernameAPI = '';
        }
      });
    });
  }

  _getMoneyData() async {
    moneyList.clear();
    setState(() {
      loading = true;
    });
    try {
      final response = await http.get(BaseURL.kDetailUrl);
      if (response.statusCode == 200) {
        final moneyData = jsonDecode(response.body);
        moneyData.forEach((data) {
          final listData = MoneyModel(
            idMoney: data['id_money'],
            image: data['image'],
            category: data['category'],
            quantity: data['quantity'],
            details: data['details'],
            date : data['date'],
            idUser: data['id_user'],
            username: data['username'],
          );
          moneyList.add(listData);
        });
        setState(() {
          loading = false;
        });
      } else {
        throw Exception('Failed to load Money Data');
      }
    }
    catch (e){
      debugPrint('Error $e');
    }
  }

  _deleteMoney(String idMoney) async {
    final response =
    await http.post(BaseURL.kDeleteUrl, body: {'id_money': idMoney});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _getMoneyData();
    } else {
      print(pesan);
    }
  }


  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Hero(
            tag: 'animasilogo',
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: Image.asset('assets/img/logomoney.jpg'),
            ),
          ),
          title: Text('Welcome $usernameAPI'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                SharedPref.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => _getMoneyData(),
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: moneyList.length,
            itemBuilder: (context, i) {
              final moneyBody = moneyList[i];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReadMoney(
                          BaseURL.kImageUrl,
                          moneyBody.image,
                          moneyBody.category,
                          moneyBody.details)));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.0,
                        height: 100.0,
                        margin: EdgeInsets.only(right: 20.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    BaseURL.kImageUrl + moneyBody.image),
                                fit: BoxFit.cover),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              moneyBody.category,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                Text(moneyBody.details),
                                Text('  |  '),
                                Text(moneyBody.date),
                              ],
                            ),
                            Row(
                              children: [
                                MaterialButton(
                                  color: kLightGreen,
                                  child: Text('Edit'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => EditMoney(
                                          moneyBody , _getMoneyData),
                                    ));
                                  },
                                ),
                                Text('  |  '),
                                MaterialButton(
                                  color: kLightGreen,
                                  child: Text('Delete'),
                                  onPressed: () {
                                    _deleteMoney(moneyBody.idMoney);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: Row(
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.green)
                ),
                color: Colors.green,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddMoneyScreen()));
    },
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.green)
                  ),
                  color: Colors.green,
                  child: Icon(
                Icons.book,
                color: Colors.white,
              ),
                  onPressed: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => About()));
              }),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.green)
                  ),
                  color: Colors.green,
                  child: Icon(
                Icons.person,
                color: Colors.white,
              ),
                  onPressed: (){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => CreatedBy()));
                  }),
            ]
        ),
      ),
    );
  }
}