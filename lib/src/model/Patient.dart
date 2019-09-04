import 'package:flutter/material.dart';

class Patient {
  final String id;
  final String lastName;
  final String firstName;
  final String middleName;
  final String prefixName;
  final String suffixName;
  final String gender;

  const Patient(
    {this.id,
    this.lastName,
    this.firstName,
    this.middleName = "",
    this.prefixName = "",
    this.suffixName = "",
    this.gender = ""});

  getName() => (prefixName == null ? "" : prefixName + " ") + firstName + " " +
      (middleName == null ? "" : middleName + " ") + lastName +
      (suffixName == null ? "" : " " + suffixName);
}