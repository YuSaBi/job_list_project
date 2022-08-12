import 'package:flutter/material.dart';

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
      child: Column(
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