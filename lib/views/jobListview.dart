import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/httpConfig.dart';
import 'package:job_list_project/models/jobResponseModel.dart';
import 'package:job_list_project/views/jobEditView.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// MAIN CLASS ///
class jobListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _jobListViewState();
  }
}

/// MAIN STATE ///
class _jobListViewState extends State {
  bool _isLoading = false;
  late SharedPreferences sharedPreferences;
  int userID = 0;
  late var veriler;
  jobResponseModel selectedJob = jobResponseModel(
      -1, "baslik", "detay", "durum", DateTime.now(), 0, "musteri", "oncelik");
  //int selectedJobId=-1;

  @override
  void initState() {
    //getID();
    setState(() {
      _isLoading = true;
      getJobs(userID);
    });
    super.initState();
  }

  void getJobs(int userID) async {
    var jsonData;
    while (true) {
      if (userID == 0) {
        try {
          sharedPreferences = await SharedPreferences.getInstance();
          userID = int.parse(sharedPreferences.getString('userID').toString());
          print(userID);
        } catch (e) {
          print("hata: " + e.toString());
          print(
              "Shared Preferences ile iligili hata var {void getJobs, Line:38 +-10}");
        }
      } else {
        try {
          postMethodConfig config = postMethodConfig();
          final response = await http.post(
            Uri.parse('${config.baseUrl}listJobs'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              // INTEGER YAPMAK GEREKEBİLİR
              "userID": userID,
            }),
          );

          if (response.statusCode == 200) {
            jsonData = json.decode(response.body);
            if (jsonData["responseCode"] == 1) {
              veriler = jsonData["jobslist"];
            } else if(jsonData["responseCode"] == 303) {
              print("ResponseCode 303 olarak döndü");
              veriler = "empty";
            }
          } else {
            // response.statusCode != 200
            print("responseCode ${response.statusCode.toString()} olarak döndü");
          }
        } catch (e) {
          print(e.toString());
          print("Post ile ilgili bir sorun var :( userID 0 gelmiş olabilir");
        }
        break;
      }// else sonu
    }// while sonu
    setState(() {
      _isLoading = false;
    });
  }// getjobs sonu

  void delJob(int jobID) async {
    postMethodConfig config = postMethodConfig();
    try {
      final response = await http.post(
        Uri.parse('${config.baseUrl}deleteJob_Manager'), // 10.0.2.2
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          // INTEGER YAPMAK GEREKEBİLİR
          "jobID": jobID
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        // response.statusCode != 200
        print("ResponseCode is not 200 !!!");
      }
    } catch (e) {
      print("Silme işleminde bir hata oluştu :(");
    }
    getJobs(userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İş Listesi"),
        backgroundColor: Colors.teal.shade300,
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(child: builderListView()),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
    );
  }

  FutureOr onGoBackFunc(value) {
    setState(() {
      _isLoading = true;
      getJobs(userID);
    });
  }

  builderListView() {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        itemCount: veriler == "empty" ? 1 : veriler.length,
        itemBuilder: (context, index) {
          return _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade400),
                )
              : Column(
                  children: [
                    veriler == "empty" || veriler == null || veriler==[]
                        ? const Text(
                            "Henüz bu kullanıcıya ait bir job bulunmuyor")
                        : ListTile(
                            // ["jobslist"][index]["baslik"]
                            title: Text(veriler[index]
                                ["baslik"]), // ${veriler[index]["baslik"]}
                            subtitle: Text(veriler[index]["durum"]), // oğuzcan
                            leading: Text(veriler[index]["musteri"]),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                delJob(veriler[index]["id"]);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red.shade700,
                                textStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              child: const Text("sil"),
                            ),
                            onTap: () {
                              convertSelectedJob(index);
                              _isLoading=true;
                              Route route = MaterialPageRoute(
                                  builder: (context) => jobEdit(selectedJob));
                              Navigator.push(context, route).then(onGoBackFunc);
                            },
                          ),
                    const Divider(
                      height: 0.0,
                      color: Colors.teal,
                      thickness: 0.5,
                    ),
                  ],
                );
        },
      ),
    );
  }

  Future<void> refresh() async {
    getJobs(userID);
  }

  void convertSelectedJob(int index) {
    //selectedJob = veriler[index];
    selectedJob.Id = veriler[index]["id"];
    selectedJob.baslik = veriler[index]["baslik"];
    selectedJob.detay = veriler[index]["detay"];
    selectedJob.gun = DateTime.parse(veriler[index]["gun"]);
    selectedJob.harcananSure = veriler[index]["harcananSure"];
    selectedJob.musteri = veriler[index]["musteri"];
    selectedJob.durum = veriler[index]["durum"];
    selectedJob.oncelik = veriler[index]["oncelik"];
  }
}
