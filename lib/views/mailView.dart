import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:job_list_project/models/httpConfig.dart';
import 'package:job_list_project/models/mailResponseModel.dart';
import 'package:job_list_project/views/mailAddView.dart';
import 'package:job_list_project/views/mailDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// MAIN CLASS ///
class mailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _mailViewState();
  }
}

/// MAIN STATE ///
class _mailViewState extends State {
  bool _isLoading = false;
  late SharedPreferences sharedPreferences;
  int userID = 0;
  late var veriler;
  mailResponseModel selectedMail =
      mailResponseModel(0, 0, "0", 0, "0", "0", "0", false, DateTime.now());
  Timer? _checkMails;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
      getMails(userID);
    });
    ///--TIMER--///
    const duration = Duration(seconds:1);
    setState(() {
      _isLoading = true;
    });
    _checkMails = Timer.periodic(duration, (Timer t) => getMails(userID));
    ///---///
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _checkMails?.cancel();
  }

  void getMails(int userID) async {
    var jsonData;
    while (true) {
      if (userID == 0) {
        try {
          // local dosyalardan veri çekme işlemi
          sharedPreferences = await SharedPreferences.getInstance();
          userID = int.parse(sharedPreferences.getString("userID").toString());
          print(userID);
        } catch (e) {
          print("hata: " + e.toString());
          print(
              "shared pref ile ilgili hata var {void getMails, Line 30 +-10}");
        }
      } else {
        try {
          // Post işlemi
          postMethodConfig config = postMethodConfig();
          final response = await http.post(
            Uri.parse('${config.baseUrl}listReceivedMessage'),
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
              veriler = jsonData["mails"];
            } else if (jsonData["responseCode"] == 303) {
              print(
                  "ResponseCode 303 olarak döndü, kullanıcıya ait mesaj bulunamadı.");
              veriler = "empty";
            }
          } else {
            // response.statusCode != 200
            print(
                "responseCode ${response.statusCode.toString()} olarak döndü");
            veriler = "empty";
          }
        } catch (e) {
          print(e.toString());
          print("Post ile ilgili bir sorun var :( userID 0 gelmiş olabilir");
        }
        break;
      } // else sonu
    } // while sonu
    setState(() {
      _isLoading = false;
    });
  } // getmails sonu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mailler"),
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
                  Row(
                    children: <Widget>[
                      buildSendMailButton(),
                    ],
                  )
                ],
              ));
  }

  FutureOr onGoBackFunc(value) {
    setState(() {
      _isLoading = true;
      getMails(userID);
    });
  }

  buildSendMailButton() {
    return Flexible(
      fit: FlexFit.tight,
      flex: 3,
      child: ElevatedButton(
        // ignore: sort_child_properties_last
        child: Row(
          children: const <Widget>[
            Icon(Icons.add),
            SizedBox(
              width: 3,
            ),
            Text("Yeni Mail")
          ],
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => mailAdd(),));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.teal),
        ),
      ),
    );
  }

  builderListView() {
    return RefreshIndicator(
      onRefresh: refreshList,
      child: ListView.builder(
        reverse: false,
        itemCount: veriler == "empty" ? 1 : veriler.length,
        itemBuilder: (context, index) {
          return _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade400),
                )
              : Column(
                  children: [
                    veriler == "empty" || veriler == null || veriler == []
                        ? const Text("Henüz bir mail almadınız.")
                        : ListTile(
                            title: Text(veriler[index]["mailFromName"]),
                            subtitle: Text(
                              veriler[index]["title"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            tileColor: ReadColorControl(index),
                            leading: ReadIconControl(index),
                            //trailing: Text(veriler[index]["mailDateTime"]),
                            trailing: Text(DateFormat('EEEE, MMM d, yyyy')
                                .format(DateTime.parse(
                                    veriler[index]["mailDateTime"]))),
                            onTap: () {
                              convertSelectedMail(index);
                              mailIsReadChange(selectedMail.mailID,
                                  true); // mail açılırken true gonderilecek
                              setState(() {
                                _isLoading = true;
                              });
                              Route route = MaterialPageRoute(
                                  builder: (context) =>
                                      mailDetail(selectedMail));
                              Navigator.push(context, route).then(onGoBackFunc);
                            },
                            onLongPress: () {
                              setState(() {
                                _isLoading = true;
                              });
                              convertSelectedMail(index);
                              mailIsReadChange(selectedMail.mailID, false);
                              getMails(userID);
                            },
                          ),
                    const Divider(
                      height: 1.0,
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                  ],
                );
        },
      ),
    );
  }

  Future<void> refreshList() async {
    getMails(userID);
  }

  void convertSelectedMail(int index) {
    selectedMail.mailID = veriler[index]["mailID"];
    selectedMail.mailFromID = veriler[index]["mailFromID"];
    selectedMail.mailFromName = veriler[index]["mailFromName"];
    selectedMail.title = veriler[index]["title"];
    selectedMail.message = veriler[index]["message"];
    selectedMail.mailDateTime = DateTime.parse(veriler[index]["mailDateTime"]);
  }

  mailIsReadChange(int ID, bool isRead) async {
    var jsonData;
    // Post işlemi
    postMethodConfig config = postMethodConfig();
    final response = await http.post(
      Uri.parse('${config.baseUrl}mailIsReadChange'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        // INTEGER YAPMAK GEREKEBİLİR
        "id": ID,
        "isRead": isRead
      }),
    );
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      print("başarıılı");
    } else {
      // response.statusCode != 200
      print("başarısız");
      print("responseCode ${response.statusCode.toString()} olarak döndü");
    }
    setState(() {
      _isLoading = false;
    });
  }

  ReadIconControl(int index) {
    if (!veriler[index]["isRead"]) {
      return Icon(
        Icons.mark_email_unread_outlined,
        color: Colors.red,
      );
    } else {
      return Icon(
        Icons.mark_email_read_outlined,
        color: Colors.black54,
      );
    }
  }

  ReadColorControl(int index) {
    if (!veriler[index]["isRead"]) {
      return Colors.yellow.shade100;
    } else {
      return Colors.amber.shade50;
    }
  }
}
