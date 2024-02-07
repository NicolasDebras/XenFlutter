import 'package:flutter/material.dart';
import 'package:xenflutter/services/AuthService.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/services/api_service.dart';
import 'design/DynamicContent.dart';
import 'models/AuthState.dart';
import 'models/user.dart';
import 'register.dart';
import 'header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Ce constructeur permet de ne pas avoir besoin de marquer key comme const.
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),
        ChangeNotifierProvider<AuthState>(
          create: (_) => AuthState(user: User.empty()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: Scaffold(
        body: Column(
          children: [
            Header(),
            Expanded(
              child: DynamicContent(),
            ),
          ],
        ),
      ),
    );
  }
}
