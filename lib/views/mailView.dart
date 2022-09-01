import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:job_list_project/models/httpConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// MAIN CLASS ///
class mailView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _mailViewState();
  }
  
}

/// MAIN STATE ///
class _mailViewState extends State{
  bool _isLoading = false;
  late SharedPreferences sharedPreferences;
  int userID = 0;
  late var veriler;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
      getMails(userID);
    });
    super.initState();
  }

  void getMails(int userID) async {
    var jsonData;

    while (true) {
      if (userID == 0) {
        try {
          sharedPreferences = await SharedPreferences.getInstance();
          userID = int.parse(sharedPreferences.getString("userID").toString());
          print(userID);
        } catch (e) {
          print("hata: "+ e.toString());
          print("shared pref ile ilgili hata var {void getMails, Line 30 +-10}");
        }
      } else {
        try {
          postMethodConfig config = postMethodConfig();
          //final Response = await http.post()
        } catch (e) {
          
        }
        break;
      }// else sonu
    }// while sonu
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mesajlar"),
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
        child:  CircularProgressIndicator(),
      )
      : Column(
        children: <Widget>[
          Expanded(child: builderListView()),
          const SizedBox(
            height: 5.0,
          ),
        ],
      )
    );
  }
  
  builderListView() {
    return RefreshIndicator(
      onRefresh: refreshList(),
      child: ListView.builder(
        itemCount: veriler == "empty" ? 1 : veriler.length ,
        itemBuilder: (context, index) {
          return _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey.shade400
              ),
          )
          : Column(
            children: [
              veriler == "empty" || veriler == null || veriler==[]
                ? const Text(
                  "Henüz bir mail almadınız."
                )
                : const Text("Mail almışsınız, ekrana yazdırılacak") // gelen mailler ekranda listelenecek
            ],
          );
        },
      ),
    );
  }
  
  refreshList() {
    return null;
  }

}