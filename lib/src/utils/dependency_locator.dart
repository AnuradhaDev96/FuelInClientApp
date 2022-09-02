import 'package:get_it/get_it.dart';

import '../models/change_notifiers/credit_card_notifier.dart';
import '../models/change_notifiers/reservation_notifier.dart';
import '../models/change_notifiers/side_drawer_notifier.dart';
import '../services/accommodation_service.dart';
import '../services/auth_service.dart';
import '../services/employee_service.dart';
import '../services/reservation_service.dart';
import 'navigation_utils.dart';

void injectAppDependencies() {
  // Notifiers
  GetIt.I.registerLazySingleton(() => SideDrawerNotifier());
  GetIt.I.registerLazySingleton(() => ReservationNotifier());
  GetIt.I.registerLazySingleton(() => CreditCardNotifier());

  // Utils
  GetIt.I.registerLazySingleton(() => NavigationUtils());

  // Singleton services
  GetIt.I.registerLazySingleton(() => AuthService());
  GetIt.I.registerLazySingleton(() => EmployeeService());
  GetIt.I.registerLazySingleton(() => AccommodationService());
  GetIt.I.registerLazySingleton(() => ReservationService());
}