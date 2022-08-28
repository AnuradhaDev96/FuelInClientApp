import 'package:get_it/get_it.dart';

import '../models/change_notifiers/side_drawer_notifier.dart';
import '../services/auth_service.dart';
import '../services/employee_service.dart';
import 'navigation_utils.dart';

void injectAppDependencies() {
  // Notifiers
  GetIt.I.registerLazySingleton(() => SideDrawerNotifier());

  // Utils
  GetIt.I.registerLazySingleton(() => NavigationUtils());

  // Singleton services
  GetIt.I.registerLazySingleton(() => AuthService());
  GetIt.I.registerLazySingleton(() => EmployeeService());
}