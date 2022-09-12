import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matara_division_system/src/ui/landing_page/landing_page.dart';
import 'package:provider/provider.dart';
import 'src/models/change_notifiers/checkin_customer_page_view_notifier.dart';

import 'firebase_options.dart';
import 'src/config/app_colors.dart';
import 'src/models/change_notifiers/accommodation_search_result_notifier.dart';
import 'src/models/change_notifiers/credit_card_notifier.dart';
import 'src/models/change_notifiers/reservation_notifier.dart';
import 'src/models/change_notifiers/side_drawer_notifier.dart';
import 'src/ui/widgets/admin_home/admin_home.dart';
import 'src/ui/widgets/reader_home/reader_home.dart';
import 'src/utils/dependency_locator.dart';


void main() {

  runZonedGuarded<Future<void>>(()  async {
    WidgetsFlutterBinding.ensureInitialized();

    FirebaseApp firebaseApp = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    if (kDebugMode) {
      print("FirebaseApp initialized $firebaseApp");
    }
    injectAppDependencies();

    runApp(const MyApp());
  }, (error, stack) {
    print("cError: $error");
    print("StackTrace: $stack");
  });

}

// Future<void> initializeData() {
//
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SideDrawerNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReservationNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreditCardNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccommodationSearchResultNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckInCustomerPageViewNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Matara Portal',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.grey,
          brightness: Brightness.light,
          primaryColor: AppColors.grayForPrimary,
          fontFamily: 'DL-Paras',
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: AppColors.silverPurple,
              onPrimary: AppColors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              textStyle: const TextStyle(
                fontFamily: 'DL-Paras',
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18.0
              )
            )
          ),
          scaffoldBackgroundColor: AppColors.white,
          // textTheme: TextTheme()

        ),
        // home: const ReaderHome(),
        // home: const AdminHome(),
        home: const LandingPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
