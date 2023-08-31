import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:student_mngt_image/student/logics/provider.dart';
import 'package:student_mngt_image/student/models/student_model.dart';

import 'package:student_mngt_image/student/pages/todoScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  //Initialize Hive database
  Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('students');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        title: 'MVVM Todo App',
        home: TodoScreen(),
      ),
    );
  }
}
