import 'package:drohealthapp/bloc/cart/product_bloc.dart';
import 'package:drohealthapp/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/cart/cart_bloc.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          Provider<CartBloc>(create: (_) => CartBloc()),
          Provider<ProductBloc>(create: (_) => ProductBloc()),
        ],
        child: MyApp()  )
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return   ChangeNotifierProvider<CartBloc>(
      create: (context) => CartBloc(),
     child:  ChangeNotifierProvider<ProductBloc>(
       create: (context) => ProductBloc(),
       child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            appBarTheme: AppBarTheme(
              brightness: Brightness.light,
              backwardsCompatibility: false, // 1
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            primarySwatch: Colors.blue,
          ),
          home:   Dashboard(),
        ),
     ),
    );
  }
}

