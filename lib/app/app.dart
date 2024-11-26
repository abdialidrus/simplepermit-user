import 'package:permit_user_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:permit_user_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:permit_user_app/ui/views/home/home_view.dart';
import 'package:permit_user_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:permit_user_app/ui/views/landing/landing_view.dart';
import 'package:permit_user_app/ui/views/application/application_view.dart';
import 'package:permit_user_app/services/application_service.dart';
import 'package:permit_user_app/services/location_service.dart';
import 'package:permit_user_app/ui/views/privacy_policy/privacy_policy_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LandingView),
    MaterialRoute(page: ApplicationView),
    MaterialRoute(page: PrivacyPolicyView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApplicationService),
    LazySingleton(classType: LocationService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
