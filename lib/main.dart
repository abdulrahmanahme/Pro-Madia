import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promadia/view/gellary_screen.dart';
import 'package:promadia/view/login_screen.dart';
import 'package:promadia/view_model.dart/cubit/cubit.dart';
import 'package:promadia/view_model.dart/dio/dio.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
   DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer( 
  builder: (context, orientation, screenType) {
    return
     MultiBlocProvider(
      providers: [
        BlocProvider<GellaryCubit>(
          create: (BuildContext context) => GellaryCubit()..getProducts(),
        ),
        
      ],
       child: MaterialApp(
          title: 'Task',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
          
            primarySwatch: Colors.blue,
          ),
          home:  LoginScreen(),
        ),
     );
  }
    );
  
  }
}


