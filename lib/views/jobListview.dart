import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// MAIN CLASS ///
class jobListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _jobListViewState();
  }

}

/// MAIN STATE ///
class _jobListViewState extends State {
  List sayilar = [
    64,48,25,15,78,26,84,98,25,74,12,34
  ];
  bool _isLoading=false;
  late SharedPreferences sharedPreferences;
  int userID=0;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    if (getID()) {
      getJobs(userID);
    }
    getID();
    
    
    super.initState();
  }

  getID() async{
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      this.userID=int.parse(sharedPreferences.getString('userID').toString());
      print(userID);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void getJobs(int userID) async{
    var jsonData;
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/Default/viewJobs'),// 10.0.2.2
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{ // INTEGER YAPMAK GEREKEBİLİR
      "userID": userID,
      }),
    );

    if (response.statusCode == 200) {
      jsonData=json.decode(response.body);
      setState(() {
        _isLoading = false;
      });
    } else {// response.statusCode != 200
      print("REsponseCode is not 200 !!!");
      setState(() {
        _isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İş Listesi"),
        backgroundColor: Colors.teal.shade300,
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }
  
  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _isLoading ? Center(child: CircularProgressIndicator(),) : Column(
        children: <Widget>[
          Expanded(
            child: builderListView()
          ),
          SizedBox(height: 5.0,),
          //Text("Seçili olan: "),
          /*
          Row(
            children: <Widget>[

            ],
          )
          */
        ],
      ),
    );
  }
  
  builderListView() {
    return ListView.builder(
      itemCount: sayilar.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text("iş: ${sayilar[index]}"),
              trailing: ElevatedButton(
                onPressed: (){ },
                child: Text("sil"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.shade700,
                  textStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(height: 0.0, color: Colors.teal, thickness: 0.5,),
          ],
        );
      },
    );
  }
  

  
  

}