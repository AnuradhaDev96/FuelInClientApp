import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../models/authentication/system_user.dart';
import '../../models/enums/user_types.dart';
import '../../services/auth_service.dart';

class PermissionBasedWidget extends StatelessWidget {
  const PermissionBasedWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SystemUser?>(
      future: GetIt.I<AuthService>().permissionsListForUser(),
      builder: (BuildContext context, AsyncSnapshot<SystemUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return const SizedBox(width: 0, height: 0);
        } else if (snapshot.hasData) {
          if (snapshot.data!.type == UserTypes.systemAdmin.toDBValue()) {
            return child;
          } else {
            return const SizedBox(width: 0, height: 0);
          }
        }
        return const SizedBox(width: 0, height: 0);
      },
    );
  }
}
