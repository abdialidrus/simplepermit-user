import 'package:flutter/material.dart';
import 'package:local_storage_permit_api/local_storage_permit_api.dart';
import 'package:simple_permit_user/app/app.dart';
import 'package:simple_permit_user/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final permitApi = LocalStoragePermitApi(
    plugin: await SharedPreferences.getInstance(),
  );

  await bootstrap(
    (permitRepository) => App(permitRepository: permitRepository),
    permitApi: permitApi,
  );
}
