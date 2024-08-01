import 'package:flutter/material.dart';
import 'package:userdetailsapp/_MyHomePageState.dart';
import 'package:userdetailsapp/dependancyInjection.dart';

void main() {
  runApp(const MyApp());
  Dependancyinjection.init();
}
