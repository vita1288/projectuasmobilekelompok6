import 'package:flutter/material.dart';
import 'package:projectuasmobilekelompok6/models/constant.dart';
import 'package:projectuasmobilekelompok6/models/moneymodels.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditMoney extends StatefulWidget {
  final MoneyModel model;
  final VoidCallback reload;
  EditMoney(this.model, this.reload);
  @override
  _EditMoneyState createState() => _EditMoneyState();
}

class _EditMoneyState extends State<EditMoney>
{
  String category, quantity, details, idUser;
  File _imageFile;
  final picker = ImagePicker();
  final _key = GlobalKey<FormState>();
  TextEditingController categoryText, quantityText, detailsText;
  void _check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _submit();
    }
  }

  _getDataToEdit() async{
    categoryText = TextEditingController(text: widget.model.category);
    quantityText = TextEditingController(text: widget.model.quantity);
    detailsText= TextEditingController(text: widget.model.details);
  }




  _selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
    setState(() {
      if(pickedFile != null)
      {
        _imageFile = File(pickedFile.path);

      }
      else
      {
        print('No Image Selected');
      }
    });
  }

  _submit() async
  {
    try {
      var uri = Uri.parse(BaseURL.kEditUrl);
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', _imageFile.path));
      request.fields['category'] = category;
      request.fields['quantity'] = quantity;
      request.fields['details'] = details;
      request.fields['id_user'] = idUser;
      request.fields['id_money'] = widget.model.idMoney;
      var response = await request.send();
      if(response.statusCode == 200)
      {
        print('Edit Success');
        setState(() {
          widget.reload();
        });
        Navigator.pop(context);

      }
      else{
        print('Edit Failed');
      }

    }
    catch (e){
      debugPrint('Error $e');
    }
  }

  _getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getString('idUser');
    });
  }

  @override
  void initState() {
    super.initState();
    _getPref();
    _getDataToEdit();
  }
  @override
  Widget build(BuildContext context) {
    var placeHolder = Container(
      width: 150,
      child: Image.asset('assets/img/blankimage.png'),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150.0,
                  child: InkWell(
                      child: _imageFile == null ? Image.network(BaseURL.kImageUrl + widget.model.image) : Image.file(_imageFile, fit: BoxFit.fill,
                      ),
                      onTap: ()
                      {
                        _selectImage();
                      }),
                ),
                TextFormField(
                  controller: categoryText,
                  decoration: kTextFieldDecoration.copyWith(labelText: 'Category'),
                  onSaved: (value) => category = value,
                ),
                TextFormField(
                  controller: quantityText,
                  decoration: kTextFieldDecoration.copyWith(labelText: 'Quantity'),
                  onSaved: (value) => quantity = value,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: detailsText,
                  decoration: kTextFieldDecoration.copyWith(labelText: 'Details'),
                  onSaved: (value) => details = value,
                  maxLines: null,
                ),
                FullWidthRoundButton(
                  getPressed: () {
                    _check();
                  },
                  textButton: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}