import 'package:get_it/get_it.dart';
import '../models/change_notifiers/side_drawer_notifier.dart';

void injectAppDependencies() {
  // Notifiers
  GetIt.I.registerLazySingleton(() => SideDrawerNotifier());
}