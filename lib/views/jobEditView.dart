import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_list_project/models/jobRequestModel.dart';
import 'package:job_list_project/models/jobResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/httpConfig.dart';

/// MAIN CLASS ///
class jobEdit extends StatefulWidget {
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
  bool _isLoading = false;

  List<String> musteri = ["shell", "bp", "opet"];
  String? musteriSelectedVal;
  List<String> durum = ["yeni", "devam", "bitti"];
  String? durumSelectedVal;
  List<String> oncelik = ["düşük", "orta", "yüksek"]; // SUNUCUDAN ÇEKİLECEK
  String? oncelikSelectedVal;
  
  bool ilkGirisMusteri = true;
  bool ilkGirisDurum = true;
  bool ilkGirisOncelik = true;
  //late SharedPreferences sharedPreferences;
  jobResponseModel selectedJob;
  jobRequestModel editedJob = jobRequestModel(-1, "", "", 1, 1, 1, 1);

  _jobEdit(this.selectedJob);

  @override
  void initState() {
    //getUserID();
    //getCustomer();
    super.initState();
  }

  getCustomer() {}

  /*getUserID() async{
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
          key: _formKey, // Ihtiyac olmayacak gibi
          child: SingleChildScrollView(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      buildBaslikField(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      buildDetayField(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      buildGunFiled(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      buildHarcanansureField(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      buildMusteriField(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      buildDurumField(),
                      const SizedBox(
                        height: 5.0,
                      ),
                      buildOncelikField(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      buildSubmitButton()
                    ],
                  ),
          )),
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
        editedJob.baslik = newValue;
        editedJob.Id = selectedJob.Id;
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
        editedJob.detay = newValue;
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
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return "Harcanan süre değeri boş bırakılamaz";
        }
      }),
      initialValue: selectedJob.harcananSure.toString(),
      onSaved: (newValue) {
        editedJob.harcananSure = int.parse(newValue.toString());
      },
    );
  }

  buildMusteriField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Müşteri: "),
        DropdownButton<String>(
          items: musteri.map(buildMusteriItem).toList(),
          //onChanged: (value) => setState(() => this.musteriSelectedVal =value),
          onChanged: (value) {
            ilkGirisMusteri=false;
            setState(() {
              this.musteriSelectedVal = value;
              //editedJob.musteri = int.parse(value.toString())
            });
            editedJob.musteri = musteri.indexOf(value.toString())+1;
          },
          value: ilkGirisMusteri ? selectedJob.musteri : musteriSelectedVal,
          alignment: Alignment.centerRight,
        ),
      ],
    );
    /*
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
    */
  }

  DropdownMenuItem<String> buildMusteriItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      //style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  buildDurumField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Durum: "),
        DropdownButton<String>(
          items: durum.map(buildDurumItem).toList(),
          //onChanged: (value) => setState(() => this.durumSelectedVal =value),
          onChanged: (value) {
            ilkGirisDurum=false;
            setState(() {
              this.durumSelectedVal = value;
            });
              editedJob.durum = durum.indexOf(value.toString())+1;
          },
          value: ilkGirisDurum ? selectedJob.durum : durumSelectedVal,
          alignment: Alignment.centerRight,
        ),
      ],
    );
    /*
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
    */
  }

  DropdownMenuItem<String> buildDurumItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          //style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  buildOncelikField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Öncelik"),
        DropdownButton<String>(
          items: oncelik.map(buildOncelikItem).toList(),
          //onChanged: (value) => setState(() => this.oncelikSelectedVal =value),
          onChanged: (value) {
            ilkGirisOncelik=false;
            setState(() {
              this.oncelikSelectedVal = value;
            });
              editedJob.oncelik = oncelik.indexOf(value.toString())+1;
          },
          value: ilkGirisOncelik ? selectedJob.oncelik : oncelikSelectedVal,
          alignment: Alignment.centerRight,
        ),
      ],
    );
    /*
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
    */
  }

  DropdownMenuItem<String> buildOncelikItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          //style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.teal, minimumSize: const Size(80.0, 40.0)),
      child: const Text("Kaydet"),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });
          _formKey.currentState!.save();
          setJob();
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lütfen boş alanları doldurunuz')),
          );
        }
      },
    );
  }

  void setJob() async {
    var jsonData;
    postMethodConfig config = postMethodConfig();
    try {
      int resp;
      final response = await http.post(
        Uri.parse('${config.baseUrl}editJob_Manager'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          // INTEGER YAPMAK GEREKEBİLİR
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
        jsonData = json.decode(response.body);
        setState(() {
          _isLoading = false;
        });
        if (jsonData == 301) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kayıt işlemi başarılı')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Hata kodu: ${jsonData['responseCode'].toString()}')),
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
      print("Post ile ilgili bir sorun var :( jobeditView Line: 277");
    }

    _isLoading = false;
  }
}
