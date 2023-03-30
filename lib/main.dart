import 'package:calculator/calculator_home.dart';
import 'package:calculator/history.dart';
import 'package:calculator/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("History");
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => CalculatorProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          // useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const CalculatorHome(),
          "/history": (context) => History(),
        });
  }
}
