import 'package:flutter/material.dart';
import 'package:projectuasmobilekelompok6/models/constant.dart';

class ReadMoney extends StatefulWidget {
  final String imgUrl;
  final String moneymodelImg;
  final String moneymodelcategory;
  final String moneymodeldetails;

  ReadMoney(this.imgUrl, this.moneymodelImg, this.moneymodelcategory, this.moneymodeldetails);
  @override
  _ReadMoneyState createState() => _ReadMoneyState();
}

class _ReadMoneyState extends State<ReadMoney>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBox) {
      return [
      SliverAppBar(
        centerTitle: true,
      backgroundColor: kLightGreen,
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
          color: kLightGreen.withOpacity(0.5),
          child: Text(widget.moneymodelcategory,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        background: Image.network('${widget.imgUrl + widget.moneymodelImg}', fit: BoxFit.cover,),
      ),
      ),
      ];
    },
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(widget.moneymodeldetails, textAlign: TextAlign.justify),
      ),
    ),
    );
  }
}