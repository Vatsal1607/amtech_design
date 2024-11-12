import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/bottom_bar/bottom_bar_page.dart';
import 'pages/bottom_bar/bottom_bar_provider.dart';
import 'pages/menu/menu_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomBarProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AMTech design',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomBarPage(),
      ),
    );
  }
}
