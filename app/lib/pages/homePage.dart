// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hive/hive.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:app/config/constants.dart';
// import 'package:app/services/classify.dart';
// import 'package:app/services/disease_provider.dart';
// import 'package:app/services/hive_database.dart';
// import 'package:app/src/home_page/components/greeting.dart';
// import 'package:app/src/home_page/components/history.dart';
// import 'package:app/src/home_page/components/titlesection.dart';
// import 'package:app/src/home_page/models/disease_model.dart';
// import 'package:app/src/suggestions_page/suggestions.dart';
// import 'package:provider/provider.dart';
// import 'package:app/pages/accountPage.dart';
// import 'package:app/pages/plantPage.dart';
// import 'package:app/widgets/widgets.dart';
// import 'package:iconsax/iconsax.dart';

// class HomePage extends StatefulWidget {
//   static const String route = '/';
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int currentPage = 0;
//   final List pages = [HomeContent(), PlantPage(), AccountPage()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: pages[currentPage],
//       bottomNavigationBar: BottomNavigator(
//         onTabChange: (_currentIndex) {
//           setState(() {
//             currentPage = _currentIndex;
//           });
//         },
//         tabs: [
//           TabButton(
//             icon: Iconsax.home,
//             text: 'Home',
//           ),
//           TabButton(
//             icon: Iconsax.home,
//             text: 'My Plants',
//           ),
//           TabButton(
//             icon: Iconsax.profile_circle4,
//             text: 'Profile',
//           )
//         ],
//       ),
//     );
//   }
// }

// class HomeContent extends StatefulWidget {
//   const HomeContent({Key? key}) : super(key: key);

//   @override
//   State<HomeContent> createState() => _HomeContentState();
// }

// class _HomeContentState extends State<HomeContent> {
//   @override
//   void dispose() {
//     Hive.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get disease from provider
//     final _diseaseService = Provider.of<DiseaseService>(context);

//     // Hive service
//     HiveService _hiveService = HiveService();

//     // Data
//     Size size = MediaQuery.of(context).size;
//     final Classifier classifier = Classifier();
//     late Disease _disease;

//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: SpeedDial(
//         icon: Icons.camera_alt,
//         spacing: 10,
//         children: [
//           SpeedDialChild(
//             child: const FaIcon(
//               Icons.image_search,
//               color: kWhite,
//             ),
//             label: "Gallery",
//             backgroundColor: kMain,
//             onTap: () async {
//               late double _confidence;
//               await classifier.getDisease(ImageSource.gallery).then((value) {
//                 _disease = Disease(
//                     name: value![0]["label"],
//                     imagePath: classifier.imageFile.path);

//                 _confidence = value[0]['confidence'];
//               });
//               // Check confidence
//               if (_confidence > 0.8) {
//                 // Set disease for Disease Service
//                 _diseaseService.setDiseaseValue(_disease);

//                 // Save disease
//                 _hiveService.addDisease(_disease);

//                 Navigator.restorablePushNamed(
//                   context,
//                   Suggestions.routeName,
//                 );
//               }
//             },
//           ),
//           SpeedDialChild(
//             child: const FaIcon(
//               FontAwesomeIcons.camera,
//               color: kWhite,
//             ),
//             label: "Camera",
//             backgroundColor: kMain,
//             onTap: () async {
//               late double _confidence;

//               await classifier.getDisease(ImageSource.camera).then((value) {
//                 _disease = Disease(
//                     name: value![0]["label"],
//                     imagePath: classifier.imageFile.path);

//                 _confidence = value[0]['confidence'];
//               });

//               // Check confidence
//               if (_confidence > 0.8) {
//                 // Set disease for Disease Service
//                 _diseaseService.setDiseaseValue(_disease);

//                 // Save disease
//                 _hiveService.addDisease(_disease);

//                 Navigator.restorablePushNamed(
//                   context,
//                   Suggestions.routeName,
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(color: Colors.green.shade100),
//         child: CustomScrollView(
//           slivers: [
//             GreetingSection(size.height * 0.2),
//             TitleSection(
//               'Your History',
//               size.height * 0.066,
//             ),
//             HistorySection(size, context, _diseaseService)
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app/config/themes/theme.dart';
import 'package:app/services/disease_provider.dart';
import 'package:app/src/home_page/models/disease_model.dart';
import 'package:app/src/suggestions_page/suggestions.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/services/classify.dart';
import 'package:app/services/hive_database.dart';
import 'package:iconsax/iconsax.dart';
import 'package:app/pages/accountPage.dart';
import 'package:app/pages/plantPage.dart';
import 'package:app/config/constants.dart';
import 'package:app/src/home_page/components/greeting.dart';
import 'package:app/src/home_page/components/history.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:app/src/home_page/components/titlesection.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiseaseService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Plant Disease Detector',
            themeMode: themeProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: '/',
            routes: {
              // Trang chính là HomePage
              '/plant': (context) => PlantPage(), // Trang PlantPage
              '/account': (context) => AccountPage(),

              Suggestions.routeName: (context) =>
                  const Suggestions(), // Add this route
            },
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static const String route = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  final List pages = [PlantPage(), CameraPage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Iconsax.home),
          //   label: 'My Plants',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle4),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _diseaseService = Provider.of<DiseaseService>(context);
    final HiveService _hiveService = HiveService();
    Size size = MediaQuery.of(context).size;
    final Classifier classifier = Classifier();
    late Disease _disease;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SpeedDial(
        icon: Icons.camera_alt,
        spacing: 10,
        children: [
          SpeedDialChild(
            child: const FaIcon(
              Icons.image_search,
              color: Colors.white,
            ),
            label: "Gallery",
            backgroundColor: Colors.green,
            onTap: () async {
              late double _confidence;
              await classifier.getDisease(ImageSource.gallery).then((value) {
                _disease = Disease(
                    name: value![0]["label"],
                    imagePath: classifier.imageFile.path);

                _confidence = value[0]['confidence'];
              });
              if (_confidence > 0.8) {
                _diseaseService.setDiseaseValue(_disease);
                _hiveService.addDisease(_disease);

                Navigator.pushNamed(context, Suggestions.routeName);
              }
            },
          ),
          SpeedDialChild(
            child: const FaIcon(
              FontAwesomeIcons.camera,
              color: Colors.white,
            ),
            label: "Camera",
            backgroundColor: Colors.green,
            onTap: () async {
              late double _confidence;

              await classifier.getDisease(ImageSource.camera).then((value) {
                _disease = Disease(
                    name: value![0]["label"],
                    imagePath: classifier.imageFile.path);

                _confidence = value[0]['confidence'];
              });

              if (_confidence > 0.8) {
                _diseaseService.setDiseaseValue(_disease);
                _hiveService.addDisease(_disease);

                Navigator.pushNamed(context, Suggestions.routeName);
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.green.shade100),
        child: CustomScrollView(
          slivers: [
            GreetingSection(size.height * 0.2),
            TitleSection(
              'Your History',
              size.height * 0.066,
            ),
            HistorySection(size, context, _diseaseService)
          ],
        ),
      ),
    );
  }
}
// CameraPage for Camera tab
// class CameraPage extends StatelessWidget {
//   @override
//   void dispose() {
//     Hive.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get disease from provider
//     final _diseaseService = Provider.of<DiseaseService>(context);

//     // Hive service
//     HiveService _hiveService = HiveService();

//     // Data
//     Size size = MediaQuery.of(context).size;
//     final Classifier classifier = Classifier();
//     late Disease _disease;

//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: SpeedDial(
//         icon: Icons.camera_alt,
//         spacing: 10,
//         children: [
//           SpeedDialChild(
//             child: const FaIcon(
//               Icons.image_search,
//               color: kWhite,
//             ),
//             label: "Gallery",
//             backgroundColor: kMain,
//             onTap: () async {
//               late double _confidence;
//               await classifier.getDisease(ImageSource.gallery).then((value) {
//                 _disease = Disease(
//                     name: value![0]["label"],
//                     imagePath: classifier.imageFile.path);

//                 _confidence = value[0]['confidence'];
//               });
//               // Check confidence
//               if (_confidence > 0.8) {
//                 // Set disease for Disease Service
//                 _diseaseService.setDiseaseValue(_disease);

//                 // Save disease
//                 _hiveService.addDisease(_disease);

//                 Navigator.restorablePushNamed(
//                   context,
//                   Suggestions.routeName,
//                 );
//               }
//             },
//           ),
//           SpeedDialChild(
//             child: const FaIcon(
//               FontAwesomeIcons.camera,
//               color: kWhite,
//             ),
//             label: "Camera",
//             backgroundColor: kMain,
//             onTap: () async {
//               late double _confidence;

//               await classifier.getDisease(ImageSource.camera).then((value) {
//                 _disease = Disease(
//                     name: value![0]["label"],
//                     imagePath: classifier.imageFile.path);

//                 _confidence = value[0]['confidence'];
//               });

//               // Check confidence
//               if (_confidence > 0.8) {
//                 // Set disease for Disease Service
//                 _diseaseService.setDiseaseValue(_disease);

//                 // Save disease
//                 _hiveService.addDisease(_disease);

//                 Navigator.restorablePushNamed(
//                   context,
//                   Suggestions.routeName,
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(color: Colors.green.shade100),
//         child: CustomScrollView(
//           slivers: [
//             GreetingSection(size.height * 0.2),
//             TitleSection(
//               'Your History',
//               size.height * 0.066,
//             ),
//             HistorySection(size, context, _diseaseService)
//           ],
//         ),
//       ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     final Classifier classifier = Classifier();
//     final DiseaseService _diseaseService = Provider.of<DiseaseService>(context);
//     final HiveService _hiveService = HiveService();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Camera'),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: SpeedDial(
//         icon: Icons.camera_alt,
//         spacing: 10,
//         children: [
//           SpeedDialChild(
//             child: const FaIcon(
//               Icons.image_search,
//               color: Color.fromARGB(255, 31, 110, 63),
//             ),
//             label: "Gallery",
//             backgroundColor: Colors.green,
//             onTap: () async {
//               late double _confidence;
//               final value = await classifier.getDisease(ImageSource.gallery);
//               if (value != null) {
//                 final _disease = Disease(
//                     name: value[0]["label"],
//                     imagePath: classifier.imageFile.path);

//                 _confidence = value[0]['confidence'];

//                 if (_confidence > 0.8) {
//                   _diseaseService.setDiseaseValue(_disease);
//                   _hiveService.addDisease(_disease);

//                   Navigator.pushNamed(
//                     context,
//                     Suggestions.routeName,
//                   );
//                 }
//               }
//             },
//           ),
//           SpeedDialChild(
//             child: const FaIcon(
//               FontAwesomeIcons.camera,
//               color: Color.fromARGB(255, 19, 10, 149),
//             ),
//             label: "Camera",
//             backgroundColor: Colors.green,
//             onTap: () async {
//               late double _confidence;
//               final value = await classifier.getDisease(ImageSource.camera);
//               if (value != null) {
//                 final _disease = Disease(
//                     name: value[0]["label"],
//                     imagePath: classifier.imageFile.path);

//                 _confidence = value[0]['confidence'];

//                 if (_confidence > 0.8) {
//                   _diseaseService.setDiseaseValue(_disease);
//                   _hiveService.addDisease(_disease);

//                   Navigator.pushNamed(
//                     context,
//                     Suggestions.routeName,
//                   );
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(color: Color.fromARGB(255, 20, 199, 26)),
//         child: Center(
//           child: Text('Use the buttons to detect disease'),
//         ),
//       ),
//     );
//   }
// }

