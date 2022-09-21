import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'src/models/change_notifiers/role_management_notifier.dart';
import 'src/models/change_notifiers/administrative_units_change_notifer.dart';
import 'package:matara_division_system/src/ui/widgets/verify_email_page.dart';
import 'package:provider/provider.dart';

import 'src/utils/firebase_options.dart';
import 'src/config/app_colors.dart';
import 'src/config/app_settings.dart';
import 'src/models/authentication/authenticated_user.dart';
import 'src/models/change_notifiers/accommodation_search_result_notifier.dart';
import 'src/models/change_notifiers/access_requests_page_view_notifier.dart';
import 'src/models/change_notifiers/checkin_customer_page_view_notifier.dart';
import 'src/models/change_notifiers/application_auth_notifier.dart';
import 'src/models/change_notifiers/credit_card_notifier.dart';
import 'src/models/change_notifiers/reservation_notifier.dart';
import 'src/models/change_notifiers/side_drawer_notifier.dart';
import 'src/models/enums/user_types.dart';
import 'src/ui/landing_page/landing_page.dart';
import 'src/ui/widgets/authenticated_screen_provider.dart';
import 'src/ui/widgets/splash_web_screen.dart';
import 'src/utils/local_storage_utils.dart';
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

    Hive.registerAdapter(AuthenticatedUserAdapter());
    Hive.registerAdapter(UserTypesAdapter());
    GetIt.I<LocalStorageUtils>().hiveDbBox = await Hive.openBox(AppSettings.authHiveBox);
    
    // var value = GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.keyAppIsAuthenticated, defaultValue: false);
    // print("####hiveValeIsAuth: $value");

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
        ChangeNotifierProvider(
            create: (context) => ApplicationAuthNotifier(),
        ),
        ChangeNotifierProvider(
            create: (context) => AccessRequestsPageViewNotifier(),
        ),ChangeNotifierProvider(
            create: (context) => AdministrativeUnitsChangeNotifier(),
        ),ChangeNotifierProvider(
            create: (context) => RoleManagementNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Matara Portal',
        // navigatorKey: ,
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
              primary: AppColors.nppPurple,
              onPrimary: AppColors.white,
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
        // home: Consumer<ApplicationAuthNotifier>(
        //   builder: (BuildContext context, ApplicationAuthNotifier applicationAuthNotifier, child) {
        //     if (applicationAuthNotifier.checkAppAuthenticated()) {
        //       print("it is vadmin");
        //       return const AdminHome();
        //     }
        //     return const LandingPage();
        //   },
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            bool savedLoggedInValue =
            GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.hiveKeyAppIsAuthenticated, defaultValue: false);
            AuthenticatedUser? aUser =
                GetIt.I<LocalStorageUtils>().hiveDbBox?.get(AppSettings.hiveKeyAuthenticatedUser, defaultValue: null);
            print("################initialHiveIsLoggedIn: $savedLoggedInValue");
            print("################initialHiveIsLoggedIn: ${aUser?.toMap()}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashWebScreen();
              }
              if (snapshot.hasData) {
                // if (FirebaseAuth.instance.currentUser!.emailVerified) {
                //   return const AdminHome();
                // } else {
                //   return const VerifyEmailPage();
                // }
                // return const AdminHome();
                return const AuthenticatedScreenProvider();
              } else {
                return LandingPage();
              }
          },
        ),
      ),
    );
  }
}

// class ScreenProvider extends StatelessWidget {
//   const ScreenProvider({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final applicationAuthNotifier = Provider.of<ApplicationAuthNotifier>(context);
//     if (applicationAuthNotifier.isAppAuthenticated && applicationAuthNotifier.authenticatedUser?.userType == UserTypes.systemAdmin) {
//       print("it is vadmin");
//       return const AdminHome();
//     }
//     return const LandingPage();
//   }
// }
