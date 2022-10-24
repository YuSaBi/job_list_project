//import 'dart:ffi';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:job_list_project/models/httpConfig.dart';
import 'package:job_list_project/models/mailRequestModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// MAIN CLASS ///
class mailAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _mailAdd();
  }
  
}

/// MAIN STATE ///
class _mailAdd extends State {
  late SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  mailRequestModel eklenecekMail = mailRequestModel(-1, -1, "", "");
  bool _isLoading = false;
  int userID = -1;

  @override
  void initState() {
    getUserID();
    super.initState();
  }

  getUserID() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      userID = int.parse(sharedPreferences.getString('userID').toString());
      eklenecekMail.fromID=userID;
    } catch (e) {
      print(e.toString());
      print("Shared preferences ile ilgili hata var");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("yeni mail"),
        backgroundColor: Colors.teal.shade300,
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }
  
  /// BODY ///
  buildBody() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              buildToIDField(),
              const SizedBox(
                height: 5.0,
              ),
              buildTitleField(),
              const SizedBox(
                height: 5.0,
              ),
              buildMessageField(),
              const SizedBox(
                height: 5.0,
              ),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
  
  buildToIDField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Alıcı ID"
      ),
      onSaved: (newValue) {
        eklenecekMail.toID=int.parse(newValue.toString());
      },
    );
  }
  
  buildTitleField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: "Başlık"
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "Başlık boş bırakılamaz";
        }
      }),
      onSaved: (newValue) {
        eklenecekMail.title=newValue.toString();
      },
    );
  }
  
  buildMessageField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: "Mesaj"
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "Boş mesaj gönderilemez";
        }
      }),
      onSaved: (newValue) {
        eklenecekMail.message=newValue.toString();
      },
    );
  }
  
  buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal.shade300,
        minimumSize: const Size(80,40)
      ),
      child: const Text("Gönder"),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });
          _formKey.currentState!.save();
          addMail(eklenecekMail);
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lütfen boş alanları doldurunuz')),
          );
        }
      },
    );
  }
  
  void addMail(mailRequestModel eklenecekMail) async{
    try {
      postMethodConfig config = postMethodConfig();
      var jsonData;
      final response = await http.post(
        Uri.parse('${config.baseUrl}saveMail_Manager'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "mailFromID": eklenecekMail.fromID,
          "mailToID": eklenecekMail.toID,
          "title": eklenecekMail.title,
          "message": eklenecekMail.message,
        }),
      );
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        if (jsonData['responseCode'] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mail gönderildi')),
          );
        } 
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hata kodu: ${jsonData['responseCode']}')),
          );
        }
      } else {
        // responseStatus != 200
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('sistemsel hata Kod: 139')),
        );
      }
    } catch (e) {
      print(e.toString());
      print("post methodunda sorun var :(");
    }
  }

}