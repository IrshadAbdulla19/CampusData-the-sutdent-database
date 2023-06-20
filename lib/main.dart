import 'package:bloc_student_database/data/db/db_funtions.dart';
import 'package:bloc_student_database/data/model/student_model.dart';
import 'package:bloc_student_database/domain/ImagePicking/image_picking_bloc.dart';
import 'package:bloc_student_database/domain/bloc/student_bloc.dart';
import 'package:bloc_student_database/domain/search_bloc/bloc/search_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'presentetion/main_page/main_screen.dart';

List<String> list = [];
Future<void> main() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  await Hive.openBox<StudentModel>("students_db");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getAllstudnets();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudentBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickingBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student list',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainScreen(),
      ),
    );
  }
}
