import 'package:flutter/material.dart';

class Task {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay starttime;
  final TimeOfDay endtime;

  Task({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.starttime,
    required this.endtime,
  });
}
