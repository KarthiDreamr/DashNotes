import 'package:flutter/material.dart';
import 'package:notes/shared_preference_provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'notes_list_provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesListProvider()),
        ChangeNotifierProvider(create: (_) => SharedPreferenceProvider())
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
