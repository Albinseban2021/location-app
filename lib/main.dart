import 'package:flutter/material.dart';
import 'package:location_based_app/Provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:location_based_app/Screen/home.dart';
void main() {
  runApp(const MyApp());
}

/// The main app entry widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location Based App',
        home: Home(),
      ),
    );
  }
}
