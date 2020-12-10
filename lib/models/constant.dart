import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseURL {
  static const kLoginUrl = 'http://192.168.0.13/moneyapp-api/Api/login.php';
  static const kRegisterUrl =
      'http://192.168.0.13/moneyapp-api/Api/register.php';
  static const kAddmoneyUrl =
      'http://192.168.0.13/moneyapp-api/Api/addmoney.php';
  static const kDetailUrl =
      'http://192.168.0.13/moneyapp-api/Api/detailmoney.php';
  static const kEditUrl =
      'http://192.168.0.13/moneyapp-api/Api/editmoney.php';
  static const kDeleteUrl =
      'http://192.168.0.13/moneyapp-api/Api/deletemoney.php';
  static const kImageUrl =
      'http://192.168.0.13/moneyapp-api/Api/upload/';
}

Color kLightGreen = Colors.green;
Color kDarkerGreen = Colors.lightGreen;
Color kBlue = Colors.lightGreenAccent;

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromRGBO(255, 255, 255, 0.3),
  focusColor: Color.fromRGBO(211, 211, 211, 1.0),
  hintText: '',
  hintStyle: TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.w800,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
