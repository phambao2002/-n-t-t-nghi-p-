// ===import 'dart:typed_data';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:app/services/disease_provider.dart';
// import 'package:app/pages/homePage.dart';
// import 'package:app/src/home_page/models/disease_model.dart';
// import 'package:app/src/suggestions_page/suggestions.dart';
// import 'package:provider/provider.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(DiseaseAdapter());

//   await Hive.openBox<Disease>('plant_diseases');

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<DiseaseService>(
//       create: (context) => DiseaseService(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Detect diseases',
//         theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'SFRegular'),
//         onGenerateRoute: (RouteSettings routeSettings) {
//           return MaterialPageRoute<void>(
//               settings: routeSettings,
//               builder: (BuildContext context) {
//                 switch (routeSettings.name) {
//                   case Suggestions.routeName:
//                     return const Suggestions();
//                   case HomePage.routeName:
//                   default:
//                     return const HomePage();
//                 }
//               });
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:app/config/themes/theme.dart';
import 'package:app/pages/homePage.dart';

import 'package:app/src/home_page/models/disease_model.dart';
import 'package:app/src/suggestions_page/suggestions.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PlantAi',
          themeMode: themeProvider.themeMode,
          theme:
              ThemeData(primarySwatch: Colors.green, fontFamily: 'SFRegular'),
          darkTheme: AppTheme.darkTheme,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case Suggestions.routeName:
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => const Suggestions(),
                );

              default:
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => const HomePage(),
                );
            }
          },
        );
      },
    );
  }
}
