import 'dart:convert';

import 'package:culion_ss/src/utils/commons.dart' as Commons;
import 'package:culion_ss/src/utils/custom_button.dart';
import 'package:culion_ss/src/utils/custom_text_field.dart';
import 'package:culion_ss/src/utils/loader.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

enum GenderFilter { ALL, MALE, FEMALE }

const YearOfDateArray = ''' 
  [
    [ 19, 20 ],
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ],
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
  ] ''';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _filterController = TextEditingController();
  GenderFilter _genderFilter = GenderFilter.ALL;
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _raceController = TextEditingController();
  TextEditingController _birthPlaceController = TextEditingController();
  TextEditingController _yearOfDeathController = TextEditingController();
  TextEditingController _dateAdmittedController = TextEditingController();
  TextEditingController _durationOfLeprosyController = TextEditingController();
  TextEditingController _lastPlaceOfResidenceController = TextEditingController();
  TextEditingController _otherDiseasesController = TextEditingController();

  showPickerArray(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: JsonDecoder().convert(YearOfDateArray),
          isArray: true,
        ),
        hideHeader: true,
//        height: 150.0,
        title: Text("Please Select", style: TextStyle(fontSize: Commons.fontSize),),
        selectedTextStyle: TextStyle(color: Commons.Colors.tertiary, fontSize: Commons.fontSize),
//        cancel: FlatButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('Cancel', style: TextStyle(fontSize: Commons.fontSize, color: Commons.Colors.tertiary))
//        ),
//        confirm: Text('OK', style: TextStyle(fontSize: Commons.fontSize, color: Commons.Colors.tertiary)),
        changeToFirst: true,
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          this.setState(() {
            _yearOfDeathController.text = "";
            picker.getSelectedValues().forEach((i) => _yearOfDeathController.text += i);
            print(_yearOfDeathController.text);
          });
        }
    ).showDialog(context);
  }

  void clear() {
    setState(() {
      _genderFilter = GenderFilter.ALL;
      _nationalityController.text = "";
      _raceController.text = "";
      _birthPlaceController.text = "";
      _yearOfDeathController.text = "";
      _dateAdmittedController.text = "";
      _durationOfLeprosyController.text = "";
      _lastPlaceOfResidenceController.text = "";
      _otherDiseasesController.text = "";
    });
  }

  void search() {
    String gender = "";
    switch(_genderFilter) {
      case GenderFilter.MALE:
        gender = "M";
        break;
      case GenderFilter.FEMALE:
        gender = "F";
        break;
      default:
        break;
    }

    print ({
      "filter": _filterController.text,
      "gender": gender,
      "nationality": _nationalityController.text,
      "race": _raceController.text,
      "birthPlace": _birthPlaceController.text,
      "yearOfDeath": _yearOfDeathController.text,
      "dateAdmitted": _dateAdmittedController.text,
      "durationOfLeprosy": _durationOfLeprosyController.text,
      "lastPlaceOfResidency": _lastPlaceOfResidenceController.text,
      "otherDiseases": _otherDiseasesController.text
    });

//    final response = await http.post("http://192.168.0.11/development/culion_ss_admin/services/search.php", body: {
    http.post("http://10.0.2.2/development/culion_ss_admin/services/search.php", body: {
      "filter": _filterController.text,
      "gender": gender,
      "nationality": _nationalityController.text,
      "race": _raceController.text,
      "birthPlace": _birthPlaceController.text,
      "yearOfDeath": _yearOfDeathController.text,
      "dateAdmitted": _dateAdmittedController.text,
      "durationOfLeprosy": _durationOfLeprosyController.text,
      "lastPlaceOfResidency": _lastPlaceOfResidenceController.text,
      "otherDiseases": _otherDiseasesController.text
    }).then((http.Response response) {
      Navigator.popAndPushNamed(context, '/results', arguments: response.body);
      clear();
    });
  }

  showAdvanceFilter() =>
    showDialog(
      context: context,
      builder: (BuildContext context) =>
        SimpleDialog(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Advance Filter Option', style: TextStyle(fontSize: Commons.fontSize, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Divider(
                    color: Commons.Colors.tertiary,
                    height: 25,
                  ),
                  Container(
                    height: 300.0,
                    width: 600.0,
                    child: ListView(

                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('Gender', style: TextStyle(fontSize: Commons.fontSize),),
                              Row(
                                children: <Widget>[
                                  FlatButton.icon(
                                      onPressed: () => setState(() => _genderFilter = GenderFilter.ALL),
                                      icon: Radio(
                                          value: GenderFilter.ALL,
                                          groupValue: _genderFilter,
                                          onChanged: (GenderFilter value) => _genderFilter = value
                                      ),
                                      label: Text('All', style: TextStyle(fontSize: Commons.fontSize))
                                  ),
                                  FlatButton.icon(
                                      onPressed: () => setState(() => _genderFilter = GenderFilter.MALE),
                                      icon: Radio(
                                          value: GenderFilter.MALE,
                                          groupValue: _genderFilter,
                                          onChanged: (GenderFilter value) => _genderFilter = value
                                      ),
                                      label: Text('Male', style: TextStyle(fontSize: Commons.fontSize))
                                  ),
                                  FlatButton.icon(
                                      onPressed: () => setState(() => _genderFilter = GenderFilter.FEMALE),
                                      icon: Radio(
                                          value: GenderFilter.FEMALE,
                                          groupValue: _genderFilter,
                                          onChanged: (GenderFilter value) => _genderFilter = value
                                      ),
                                      label: Text('Female', style: TextStyle(fontSize: Commons.fontSize))
                                  )
                                ],
                              )
                            ],
                          ),
                          width: Commons.textWidth,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              CustomTextField(label: 'Nationality', controller: _nationalityController, maxLength: 60)
                            ],
                          ),
                          width: Commons.textWidth,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              CustomTextField(label: 'Race', controller: _raceController, maxLength: 60)
                            ],
                          ),
                          width: Commons.textWidth,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              CustomTextField(label: 'Birth Place', controller: _birthPlaceController, maxLength: 60)
                            ],
                          ),
                          width: Commons.textWidth,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              CustomTextField(
                                  label: 'Year of Death',
                                  controller: _yearOfDeathController,
                                  maxLength: 60,
                                  onTap: () {
                                    Future.microtask(() => FocusScope.of(context).requestFocus(FocusNode()));
                                    showPickerArray(context);
                                  })
//                        Text('Year of Death', style: TextStyle(fontSize: Commons.fontSize)),
//                        CustomTextField(controller: _yearOfDeathController, width: 300.0, enabled: false,),
//                        CustomButton(text: 'Select', background: Commons.Colors.secondary, onPressed: () {
//                          showPickerArray(context);
//                        })
                            ],
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          width: Commons.textWidth,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: DateTimeField(
                                  format: DateFormat('yyyy-MM-dd'),
                                  decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                      hintText: 'Date admitted',
                                      hintStyle: TextStyle(fontSize: Commons.fontSize),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                                      labelText: 'Date admitted',
                                      alignLabelWithHint: true,
                                      counterText: ""
                                  ),
                                  style: TextStyle(fontSize: Commons.fontSize),
                                  controller: _dateAdmittedController,
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate: currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                ),
                                width: Commons.textWidth,
                              )
                            ],
                          ),
                          width: Commons.textWidth,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              CustomTextField(label: 'Duration of Leprosy', controller: _durationOfLeprosyController, maxLength: 60)
                            ],
                          ),
                          width: Commons.textWidth,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              CustomTextField(label: 'Last place of residence', controller: _lastPlaceOfResidenceController, maxLength: 60)
                            ],
                          ),
                          width: Commons.textWidth,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            children: <Widget>[
                              CustomTextField(label: 'Other Diseases', controller: _otherDiseasesController, maxLength: 60)
                            ],
                          ),
                          width: Commons.textWidth,
                        ),
                      ],
                    )
                  ),
                  Divider(
                    color: Commons.Colors.tertiary,
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      CustomButton(
                        text: "Search",
                        background: Commons.Colors.tertiary,
                        icon: EvaIcons.search,
                        iconSize: Commons.fontSize,
                        width: 140.0,
                        fontSize: Commons.fontSize,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                              SimpleDialog(
                                children: <Widget>[
                                  Center(child: ColorLoader(radius: 30.0, dotRadius: 15.0))
                                ],
                              )
                          );
                          Navigator.of(context).pop();
                          search();
                        },
                      ),
                      CustomButton(
                        text: "Clear",
                        background: Commons.Colors.tertiary,
                        icon: LineIcons.eraser,
                        iconSize: Commons.fontSize,
                        width: 140.0,
                        fontSize: Commons.fontSize,
                        onPressed: () {
                          clear();
                        },
                      ),
                      CustomButton(
                        text: "Cancel",
                        background: Commons.Colors.tertiary,
                        icon: LineIcons.close,
                        iconSize: Commons.fontSize,
                        width: 140.0,
                        fontSize: Commons.fontSize,
                        onPressed: () {
                          clear();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Commons.Colors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: <Widget>[
                Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 4,
                  child: Container(
                    child: TextField(
                      controller: _filterController,
                      style: TextStyle(
                        fontSize: Commons.fontSize,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide()
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Commons.Colors.tertiary),
                        ),
                        hintText: "Type keyword for name search...",
                        hintStyle: TextStyle(
                          fontSize: Commons.fontSize,
                        )
                      )
                    ),
                  ),
                ),
                Flexible(flex: 1, child: Container())
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 4,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CustomButton(
                          text: "Search",
                          background: Commons.Colors.tertiary,
                          icon: EvaIcons.search,
                          iconSize: Commons.fontSize,
                          width: 140.0,
                          fontSize: Commons.fontSize,
                          onPressed: () {
                            print('Show dialog');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                SimpleDialog(
                                  children: <Widget>[
                                    Center(child: ColorLoader(radius: 30.0, dotRadius: 15.0))
                                  ],
                                )
                            );
                            print('Before search');
                            search();
//                            Timer(Duration(seconds: 3), () {
//                              Navigator.popAndPushNamed(context, '/results');
//                            });
                          },
                        ),
                        CustomButton(
                          text: "Advance Filter",
                          background: Commons.Colors.tertiary,
                          icon: EvaIcons.funnel,
                          iconSize: Commons.fontSize,
                          width: 220.0,
                          fontSize: Commons.fontSize,
                          onPressed: () {
                            showAdvanceFilter();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(flex: 1, child: Container())
              ],
            ),
          ],
        ),
      ),
    );
  }
}