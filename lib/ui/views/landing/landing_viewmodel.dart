import 'package:stacked/stacked.dart';
import 'package:stacked_permit_user_app/app/app.locator.dart';
import 'package:stacked_permit_user_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class LandingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToHomePage() {
    _navigationService.navigateToHomeView();
  }
}
