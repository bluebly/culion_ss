import 'dart:convert';

import 'package:culion_ss/src/model/Patient.dart';
import 'package:culion_ss/src/utils/commons.dart' as Commons;
import 'package:culion_ss/src/utils/page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

  @override
  Widget build(BuildContext context) {
    List responseJson = json.decode(ModalRoute.of(context).settings.arguments);
    List<Patient> patients = [];
    // TODO: optimize
    responseJson.forEach((f) {
      print(f);
      patients.add(
        Patient(id: f['ID'], firstName: f['F_NAME'], middleName: f['M_NAME'],
            lastName: f['L_NAME'], prefixName: f['PREFIX_NAME'],
            suffixName: f['SUFFIX_NAME'], gender: f['GENDER'])
      );
    });
    print(patients);

    return Scaffold(
      backgroundColor: Commons.Colors.primary,
      body: Page(
        title: 'Patience/s List',
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 200.0,
              color: Colors.white,//70,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                itemBuilder: (context, i) {
                  return Container(
                    color: i % 2 == 0 ? Colors.white : Colors.grey,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      leading: Icon(
                        patients[i].gender == "F" ? LineIcons.female : LineIcons.male,
                        size: 50.0,),
                      title: Text(patients[i].getName(), style: TextStyle(fontSize: 20.0)),
                      onTap: () {
                        AlertStyle alertStyle = AlertStyle(
                          constraints: BoxConstraints.expand(width: 500)
                        );
                        Alert(
                          context: context,
                          title: "Proceed to request form",
                          desc: "Details are locked for confidentiality purposes. "
                              "Do you want to proceed to the patient detail request form?",
                          type: AlertType.info,
                          style: alertStyle,
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Yes",
                                style: TextStyle(color: Colors.white, fontSize: Commons.fontSize),
                              ),
                              color: Colors.blueAccent,
                              onPressed: () {
                                Navigator.of(context).popAndPushNamed('/request', arguments: patients[i].id);
                              } ),
                            DialogButton(
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.white, fontSize: Commons.fontSize),
                                ),
                                color: Colors.redAccent,
                                onPressed: () => Navigator.pop(context) )
                          ]
                        ).show();
                      },
                    ),
                  );
                },
                itemCount: patients.length
              )
            ),
            Container(
              padding: EdgeInsets.all(25.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Record Count: " + patients.length.toString(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
