import 'package:flutter/material.dart';
import 'package:playz/view/Library_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:playz/view/widgets/main_drawer.dart';
import 'firebase_options.dart';

void main() async {
  //Needs to use firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PlayZ'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: const Image(
            image: AssetImage('assets/Logo3.png'),
          ),
        ),
      ),
      endDrawer: MainDrawer(),
      body: LibraryView(),
    );
  }
}
