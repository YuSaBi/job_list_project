import 'package:flutter/material.dart';
import 'package:job_list_project/models/mailResponseModel.dart';

/// MAIN CLASS ///
class mailDetail extends StatefulWidget {
  mailResponseModel selectedMail;

  mailDetail(this.selectedMail);

  @override
  State<StatefulWidget> createState() {
    return _mailDetail(selectedMail);
  }
  
}

/// MAIN STATE ///
class _mailDetail extends State {
  mailResponseModel selectedMail;
  bool _isLoading = false;

  _mailDetail(this.selectedMail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mail içeriği"),
        backgroundColor:  Colors.teal.shade300,
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }
  
  buildBody() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Form(
        child:  SingleChildScrollView(
          child: _isLoading
          ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
          children: [
            // mailFromName, title, message, mailDateTime
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedMail.mailFromName.toString()),
                Text(selectedMail.mailDateTime.toString()),
              ],
            ),
            //buildMailFromName(),
            const SizedBox(
              height: 10.0,
            ),
            //buildTitleField(),
            const SizedBox(
              height: 5.0,
            ),
            buildMessageField()
          ],
        ),
        ),
      ),
    );
  }
  
  buildMessageField() {
    return TextFormField(
      enabled: false,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: "mesaj içeriği",
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal)
        )
      ),
      initialValue: selectedMail.message,
    );
  }
  
}