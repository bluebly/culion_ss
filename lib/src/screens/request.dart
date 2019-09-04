import 'dart:convert';

import 'package:culion_ss/src/model/Patient.dart';
import 'package:culion_ss/src/utils/commons.dart' as Commons;
import 'package:culion_ss/src/utils/custom_button.dart';
import 'package:culion_ss/src/utils/custom_text_field.dart';
import 'package:culion_ss/src/utils/custom_text_form_field.dart';
import 'package:culion_ss/src/utils/page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _middleNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _mobileNumberController = new TextEditingController();
  TextEditingController _emailAddressController = new TextEditingController();
  TextEditingController _relationshipController = new TextEditingController();
  TextEditingController _purposeController = new TextEditingController();

  clear() {
    _firstNameController.text = '';
    _middleNameController.text = '';
    _lastNameController.text = '';
    _addressController.text = '';
    _mobileNumberController.text = '';
    _emailAddressController.text = '';
    _relationshipController.text = '';
    _purposeController.text = '';
  }

  submit(patientId) {
    http.post("http://10.0.2.2/development/culion_ss_admin/services/request.php", body: {
      "patientId": patientId.toString(),
      "firstName": _firstNameController.text,
      "middleName": _middleNameController.text,
      "lastName": _lastNameController.text,
      "address": _addressController.text,
      "mobileNo": _mobileNumberController.text,
      "emailAddress": _emailAddressController.text,
      "purpose": _purposeController.text,
      "relation": _relationshipController.text
    }).then((http.Response response) {
      AlertStyle alertStyle = AlertStyle(
          constraints: BoxConstraints.expand(width: 500)
      );
      Alert(
          context: context,
          title: "Request submitted!",
          desc: "Kindly note this reference number and present to administrator's office by the end of museum tour.",
          content: Text('Ref# ' + json.decode(response.body)['refNo'].toString(), style: TextStyle(fontSize: Commons.fontSize, color: Commons.Colors.secondary),),
          type: AlertType.success,
          style: alertStyle,
          buttons: [
            DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: Commons.fontSize),
                ),
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } )
          ]
      ).show();
      clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    int patientId = json.decode(ModalRoute.of(context).settings.arguments);
    print('Request me');
    print(patientId);
    return Scaffold(
      backgroundColor: Commons.Colors.primary,
      body: Page(
        title: "Request for Patient's Details",
        buttons: <Widget>[
          CustomButton(
            text: 'Clear',
            background: Commons.Colors.tertiary,
            icon: LineIcons.eraser,
            iconSize: Commons.fontSize,
            width: 125.0,
            fontSize: Commons.fontSize,
            onPressed: () {
              clear();
            }),
          SizedBox(width: 10.0,),
          CustomButton(
            text: 'Submit',
            background: Commons.Colors.secondary,
            icon: LineIcons.check,
            iconSize: Commons.fontSize,
            width: 145.0,
            fontSize: Commons.fontSize,
            onPressed: () {
              submit(patientId);
            } ,),
        ],
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 150.0,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 90.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    CustomTextField(label: 'First Name', maxLength: 60, controller: _firstNameController)
                  ],
                ),
                width: Commons.textWidth,
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  children: <Widget>[
                    CustomTextField(label: 'Middle Name', maxLength: 60, controller: _middleNameController)
                  ],
                ),
                width: Commons.textWidth,
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  children: <Widget>[
                    CustomTextField(label: 'Last Name', maxLength: 60, controller: _lastNameController)
                  ],
                ),
                width: Commons.textWidth,
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  children: <Widget>[
                    CustomTextField(label: 'Address', maxLength: 200, maxLines: 3, controller: _addressController)
                  ],
                ),
                width: Commons.textWidth,
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  children: <Widget>[
                    CustomTextFormField(label: 'Mobile Number', maxLength: 15,
                      controller: _mobileNumberController,
                      keyboardType: TextInputType.phone,)
                  ],
                ),
                width: Commons.textWidth,
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  children: <Widget>[
                    CustomTextFormField(label: 'E-mail Address', maxLength: 30,
                      controller: _emailAddressController,
                      keyboardType: TextInputType.emailAddress,)
                  ],
                ),
                width: Commons.textWidth,
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  children: <Widget>[
                    CustomTextField(label: 'Relationship to patient', maxLength: 30, controller: _relationshipController)
                  ],
                ),
                width: Commons.textWidth,
              ),
              SizedBox(height: 20.0),
              Container(
                child: Row(
                  children: <Widget>[
                    CustomTextField(label: 'Purpose', maxLength: 50, maxLines: 3, controller: _purposeController)
                  ],
                ),
                width: Commons.textWidth,
              ),
            ],
          ),
        )
      ),
    );
  }
}
