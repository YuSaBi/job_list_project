
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_list_project/models/jobRequestModel.dart';
import 'package:job_list_project/models/jobResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/httpConfig.dart';

/// MAIN CLASS ///
class jobEdit extends StatefulWidget{
  jobResponseModel selectedJob;

  jobEdit(this.selectedJob);

  @override
  State<StatefulWidget> createState() {
    return _jobEdit(selectedJob);
  }
  
}

/// MAIN STATE ///
class _jobEdit extends State {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading=false;
  //late SharedPreferences sharedPreferences;
  jobResponseModel selectedJob;
  jobRequestModel editedJob=jobRequestModel(-1, "", "", 1, 1, 1, 1);

  _jobEdit(this.selectedJob);

  /*@override
  void initState() {
    getUserID();
    super.initState();
  }

  getUserID() async{
    sharedPreferences = await SharedPreferences.getInstance();
    editedJob.Id = selectedJob.Id;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Düzenle"),
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
        key: _formKey,// Ihtiyac olmayacak gibi
        child: SingleChildScrollView(
          child: _isLoading? const Center(child: CircularProgressIndicator(),) : Column(
            children: [
              buildBaslikField(),
              const SizedBox(height: 5.0,),
              buildDetayField(),
              const SizedBox(height: 5.0,),
              buildGunFiled(),
              const SizedBox(height: 5.0,),
              buildHarcanansureField(),
              const SizedBox(height: 5.0,),
              buildMusteriField(),
              const SizedBox(height: 5.0,),
              buildDurumField(),
              const SizedBox(height: 5.0,),
              buildOncelikField(),
              const SizedBox(height: 10.0,),
              buildSubmitButton()
            ],
          ),
        )
      ),
    );
  }
  
  buildBaslikField() {
    return TextFormField(
      
      decoration: const InputDecoration(
        labelText: "Başlık",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "başlık değeri boş bırakılamaz";
        }
      }),
      initialValue: selectedJob.baslik,
      onSaved: (newValue) {
        editedJob.baslik=newValue;
        editedJob.Id=selectedJob.Id;
      },
    );
  }
  
  buildDetayField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: "Detay",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "Detay değeri boş bırakılamaz";
        }
      }),
      initialValue: selectedJob.detay,
      onSaved: (newValue) {
        editedJob.detay=newValue;
      },
    );
  }
  
  buildGunFiled() {
    return TextFormField(
      enabled: false,
      decoration: const InputDecoration(
        labelText: "Gün",
      ),
      initialValue: selectedJob.gun.toString(),
    );
  }
  
  buildHarcanansureField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harcanan Süre (dk)",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value == null || value.isEmpty) { 
          return "Harcanan süre değeri boş bırakılamaz";
        }
      }),
      initialValue: selectedJob.harcananSure.toString(),
      onSaved: (newValue) {
       editedJob.harcananSure=int.parse(newValue.toString());
      },
    );
  }
  
  buildMusteriField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Müsteri",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "Müşteri değeri boş bırakılamaz";
        }
      }),
      initialValue: selectedJob.musteri,
      onSaved: (newValue) {
        editedJob.musteri=int.parse(newValue.toString());
      },
    );
  }
  
  buildDurumField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Durum",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "Durum değeri boş bırakılamaz";
        }
      }),
      initialValue: selectedJob.durum,
      onSaved: (newValue) {
        editedJob.durum=int.parse(newValue.toString());
      },
    );
  }
  
  buildOncelikField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Öncelik",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "Öncelik değeri boş bırakılamaz";
        }
      }),
      initialValue: selectedJob.oncelik,
      onSaved: (newValue) {
        editedJob.oncelik=int.parse(newValue.toString());
      },
    );
  }
  
  buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        minimumSize: const Size(80.0, 40.0)
      ),
      child: const Text("Kaydet"),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isLoading=true;
          });
          _formKey.currentState!.save();
          setJob();
          Navigator.pop(context);
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lütfen boş alanları doldurunuz')),
          );
        }
      },
    );
  }
  
  void setJob() async{
    var jsonData;
    postMethodConfig config = postMethodConfig();
    try {
      int resp;
      final response = await http.post(
      Uri.parse('${config.baseUrl}editJob_Manager'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{ // INTEGER YAPMAK GEREKEBİLİR
        "jobID": editedJob.Id,
        "baslik": editedJob.baslik,
        "harcananSure": editedJob.harcananSure,
        "detay": editedJob.detay,
        "customerID": editedJob.musteri,
        "durum": editedJob.durum,
        "priorityID": editedJob.oncelik
      }),
      );

      if (response.statusCode == 200) {
        jsonData=json.decode(response.body);
        setState(() {
          _isLoading = false;
        });
        if (jsonData ==301) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kayıt işlemi başarılı')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hata kodu: ${jsonData['responseCode'].toString()}')),
          );
        }
      } else {// responseStatus != 200
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('sistemsel hata Kod: 139')),
        );
      }
    } catch (e) {
      print(e.toString());
      print("Post ile ilgili bir sorun var :( jobeditView Line: 277");
    }
    
    _isLoading=false;
  
  }

}