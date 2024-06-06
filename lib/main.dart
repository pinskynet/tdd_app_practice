import 'package:flutter/material.dart';
import 'package:practice1_app/core/di/injection.dart';
import 'package:practice1_app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  runApp(const MyApp());
}
