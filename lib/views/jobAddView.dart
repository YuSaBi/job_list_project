//import 'package:flutter/cupertino.dart';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:job_list_project/models/jobRequestModel.dart';
//import 'package:job_list_project/models/jobResponseModel.dart';

/// MAIN CLASS ///
class jobAdd extends StatelessWidget {
  jobRequestModel eklenecekJob=jobRequestModel(-1, "", "",  -1, -1, -1, -1);
  final _formKey = GlobalKey<FormState>();
  //jobAdd({Key? key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İş ekle"),
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
              buildBaslikField(),
              const SizedBox(height: 5.0,),
              buildDetayField(),
              const SizedBox(height: 5.0,),
              buildCustomerIdField(),
              const SizedBox(height: 5.0,),
              buildHarcanansureField(),
              const SizedBox(height: 5.0,),
              buildDurumField(),
              const SizedBox(height: 5.0,),
              buildPriorityField(),
              const SizedBox(height: 5.0,),
              buildSubmitButton(),
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
      onSaved: (newValue) {
        eklenecekJob.baslik=newValue;
      },
    );
  }
  
  buildDetayField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Detay",
      ),
      onSaved: (newValue) {
        eklenecekJob.detay=newValue;
      },
    );
  }
  
  buildCustomerIdField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Müsteri",
      ),
      onSaved: (newValue) {
        eklenecekJob.musteri=1; // DEĞİŞTİRİLECEK
      },
    );
  }
  
  buildHarcanansureField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harcanan Süre (dk)",
      ),
      onSaved: (newValue) {
        eklenecekJob.harcananSure=int.parse(newValue.toString());
      },
    );
  }
  
  buildDurumField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Durum",
      ),
      onSaved: (newValue) {
        eklenecekJob.durum=1; // DEĞİŞTİRİLECEK
      },
    );
  }
  
  buildPriorityField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Öncelik",
      ),
      onSaved: (newValue) {
        eklenecekJob.oncelik=1; // DEĞİŞTİRİLECEK
      },
    );
  }
  
  buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        minimumSize: const Size(80, 40)
      ),
      child: const Text("Kaydet"),
      onPressed: () {
        _formKey.currentState!.save();
        
        //Navigator.pop(context);
      },
    );
  }
  
}