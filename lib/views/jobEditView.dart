//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

/// MAIN CLASS ///
class jobEdit extends StatelessWidget {
  const jobEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Düzenle"),),
      body: buildBody(),
    );
  }
  
  /// BODY ///
  buildBody() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Form(
        //key: _formKey, Ihtiyac olmayacak gibi
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
        )
      ),
    );
  }
  
  buildBaslikField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Başlık",
      ),
      initialValue: "[Default]",
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
      initialValue: "[Default]",
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
      initialValue: "[Default]",
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
      initialValue: "[Default]",
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
      initialValue: "[Default]",
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
      initialValue: "[Default]",
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
      initialValue: "[Default]",
      /*onSaved: (newValue) {
        "cart curt"
      },*/
    );
  }
  
  buildSubmitButton() {
    return ElevatedButton(
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