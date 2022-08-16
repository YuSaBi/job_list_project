//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:job_list_project/models/jobModel.dart';

/// MAIN CLASS ///
class jobEdit extends StatelessWidget {
  jobModel selectedJob;

  jobEdit(this.selectedJob);

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
        //key: _formKey, Ihtiyac olmayacak gibi
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
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
      initialValue: selectedJob.baslik,
      /*onSaved: (newValue) {
        "cart curt"
      },*/
    );
  }
  
  buildDetayField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Detay",
      ),
      initialValue: selectedJob.detay,
      /*onSaved: (newValue) {
        "cart curt"
      },*/
    );
  }
  
  buildGunFiled() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Gün",
      ),
      initialValue: selectedJob.gun.toString(),
      /*onSaved: (newValue) {
        "cart curt"
      },*/
    );
  }
  
  buildHarcanansureField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harcanan Süre (dk)",
      ),
      initialValue: selectedJob.harcananSure.toString(),
      /*onSaved: (newValue) {
        "cart curt"
      },*/
    );
  }
  
  buildMusteriField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Müsteri",
      ),
      initialValue: selectedJob.musteri,
      /*onSaved: (newValue) {
        "cart curt"
      },*/
    );
  }
  
  buildDurumField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Durum",
      ),
      initialValue: selectedJob.durum,
      /*onSaved: (newValue) {
        "cart curt"
      },*/
    );
  }
  
  buildOncelikField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Öncelik",
      ),
      initialValue: selectedJob.oncelik,
      /*onSaved: (newValue) {
        "cart curt"
      },*/
    );
  }
  
  buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal,
        onSurface: Colors.amber,
        minimumSize: Size(80.0, 40.0)
      ),
      child: const Text("Kaydet"),
      onPressed: () {
        //formKey.currentState!.save();// Tüm formField'ların onSaved'larını çalıştırır
        //widget.students[widget.index]=studentYeni; CART CURT işlemler
        //Navigator.pop(context);
        return null;
      },
    );
  }

}