import 'package:flutter/material.dart';
import 'package:projectuasmobilekelompok6/view/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:projectuasmobilekelompok6/models/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMoneyScreen extends StatefulWidget {
  @override
  _AddMoneyScreenState createState() => _AddMoneyScreenState();
  AddMoneyScreen({Key key}) : super(key: key);
  static const String id = 'addmoneyscreen';
}

class _AddMoneyScreenState extends State<AddMoneyScreen>
{
  String category, quantity, details, idUser;
  final _key = GlobalKey<FormState>();
  File _imageFile;
  final picker = ImagePicker();

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



  void _check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _submit();
    }
  }

  _submit() async
  {
   try {
     var uri = Uri.parse(BaseURL.kAddmoneyUrl);
     var request = http.MultipartRequest('POST', uri);
     request.files.add(await http.MultipartFile.fromPath('image', _imageFile.path));
     request.fields['category'] = category;
     request.fields['quantity'] = quantity;
     request.fields['details'] = details;
     request.fields['id_user'] = idUser;
     var response = await request.send();
     if(response.statusCode == 200)
       {
         print('Insert Success');
         Navigator.pop(context);

       }
     else{
       print('Insert Failed');
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
                      child: _imageFile == null ? placeHolder : Image.file(_imageFile, fit: BoxFit.fill,
                      ),
                      onTap: ()
                      {
                        _selectImage();
                      }),
                ),
             TextFormField(
               decoration: kTextFieldDecoration.copyWith(labelText: 'Category'),
               onSaved: (value) => category = value,
             ),
             TextFormField(
               decoration: kTextFieldDecoration.copyWith(labelText: 'Quantity'),
               onSaved: (value) => quantity = value,
               keyboardType: TextInputType.number,
             ),
             TextFormField(
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