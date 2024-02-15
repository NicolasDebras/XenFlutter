import 'package:flutter/material.dart';
import 'package:xenflutter/services/AuthService.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/services/provider/AuthState.dart';
import 'package:xenflutter/services/provider/PostsProvider.dart';
import 'package:xenflutter/services/provider/api_service.dart';
import 'design/DynamicContent.dart';
import 'models/user.dart';
import 'register.dart';
import 'header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        ChangeNotifierProvider<PostsProvider>(
          create: (_) => PostsProvider(),
        ),
        Provider<AuthService>(
          create: (context) => AuthService(Provider.of<ApiService>(context, listen: false).dio),
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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(),
      body: Column(
          children: [
            DynamicContent(),
          ],
      ),
    );
  }
}