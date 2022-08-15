import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_list_project/views/jobEditView.dart';
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
  bool _isLoading=false;
  late SharedPreferences sharedPreferences;
  int userID=0;
  late var veriler;

  @override
  void initState()  {
    //getID();
    setState(() {
      _isLoading = true;
    });
    getJobs(userID);
    super.initState();
  }

  /*void getID() async{
    
  }*/

  void getJobs(int userID) async{
    var jsonData;
    
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      userID=int.parse(sharedPreferences.getString('userID').toString());
      print(userID);
    } catch (e) {
      print(e.toString());
      print("Shared Preferences ile iligili hata var");
    }

    try {
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
        veriler = jsonData["jobslist"];
      } else {// response.statusCode != 200
        print("ResponseCode is not 200 !!!");
        setState(() {
          veriler = "empty";
          _isLoading = false;
        });
      }
    } catch (e) {
      //print("Post ile ilgili bir sorun var :(");
    }
    
    _isLoading=false;
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
  
  FutureOr onGoBackFunc(value) {
    setState(() { });
  }

  builderListView() {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        itemCount:veriler=="empty"? 1 : veriler.length,
        itemBuilder: (context, index) {
          return _isLoading ? Center(child: CircularProgressIndicator(backgroundColor: Colors.grey.shade400),) : Column(
            children: [
              veriler == "empty" ?
              const Text("Veriler çekilemedi, internet bağlantınızı kontrol edin") : 
              ListTile(// ["jobslist"][index]["baslik"]
                title: Text(veriler[index]["oncelik"]), // ${veriler[index]["baslik"]}
                subtitle: Text(veriler[index]["baslik"]),// oğuzcan
                leading: Text(veriler[index]["musteri"]),
                trailing: ElevatedButton(
                  onPressed: (){},
                  child: Text("sil"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade700,
                    textStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Route route = MaterialPageRoute(builder: (context) => jobEdit());
                  Navigator.push(context, route).then(onGoBackFunc);
                },
              ),
              Divider(height: 0.0, color: Colors.teal, thickness: 0.5,),
            ],
          );
        },
      ),
    );
  }

  Future<void> refresh() async{
    setState(() {
      
    });
  }
}