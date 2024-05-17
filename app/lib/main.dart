// import 'dart:typed_data';
// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app/services/disease_provider.dart';
import 'package:app/src/home_page/models/disease_model.dart';
import 'package:app/src/suggestions_page/suggestions.dart';
import 'package:provider/provider.dart';
import 'package:app/config/themes/theme.dart';
import 'package:app/pages/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiseaseAdapter());

  await Hive.openBox<Disease>('plant_diseases');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiseaseService>(
      create: (context) => DiseaseService(),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PlantAi',
            themeMode: themeProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            onGenerateRoute: (settings) {
              final String? routeName = settings.name;
              switch (routeName) {
                case Suggestions.routeName:
                  return MaterialPageRoute(builder: (_) => Suggestions());

                default:
                  return MaterialPageRoute(builder: (_) => HomePage());
              }
            },
            home: HomePage(),
          );
        },
      ),
    );
  }
}
