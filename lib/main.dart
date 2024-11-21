import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:permit_user_app/app/app.bottomsheets.dart';
import 'package:permit_user_app/app/app.dialogs.dart';
import 'package:permit_user_app/app/app.locator.dart';
import 'package:permit_user_app/app/app.router.dart';
import 'package:permit_user_app/ui/common/app_theme.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.landingView,
      theme: PermitAppTheme.light,
      darkTheme: PermitAppTheme.dark,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
        FlutterSmartDialog.observer,
      ],
      builder: FlutterSmartDialog.init(),
    );
  }
}
