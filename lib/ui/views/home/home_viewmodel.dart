import 'package:stacked_permit_user_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_permit_user_app/app/app.router.dart';
import 'package:stacked_permit_user_app/ui/views/home/widgets/user_type_menu_item.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToPermitApplicationPage(UserType userType) {
    _navigationService.navigateToApplicationView(userType: userType);
  }
}
