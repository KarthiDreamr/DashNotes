import 'package:flutter/material.dart';
import '/providers/shared_preference_provider.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'providers/notes_list_provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SharedPreferenceProvider()),
            ChangeNotifierProvider(create: (_) => NotesListProvider()),
          ],
          child: const MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<SharedPreferenceProvider>().initSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          
          context.read<NotesListProvider>().setNotesList =
              context.read<SharedPreferenceProvider>().getNotesList();

          return MaterialApp(
            title: 'Notes App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const HomePage(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
