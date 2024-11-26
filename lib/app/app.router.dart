// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i7;
import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/views/application/application_view.dart'
    as _i5;
import 'package:permit_user_app/ui/views/home/home_view.dart' as _i2;
import 'package:permit_user_app/ui/views/home/widgets/user_type_menu_item.dart'
    as _i8;
import 'package:permit_user_app/ui/views/landing/landing_view.dart' as _i4;
import 'package:permit_user_app/ui/views/privacy_policy/privacy_policy_view.dart'
    as _i6;
import 'package:permit_user_app/ui/views/startup/startup_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const landingView = '/landing-view';

  static const applicationView = '/application-view';

  static const privacyPolicyView = '/privacy-policy-view';

  static const all = <String>{
    homeView,
    startupView,
    landingView,
    applicationView,
    privacyPolicyView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.landingView,
      page: _i4.LandingView,
    ),
    _i1.RouteDef(
      Routes.applicationView,
      page: _i5.ApplicationView,
    ),
    _i1.RouteDef(
      Routes.privacyPolicyView,
      page: _i6.PrivacyPolicyView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LandingView: (data) {
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LandingView(),
        settings: data,
      );
    },
    _i5.ApplicationView: (data) {
      final args = data.getArgs<ApplicationViewArguments>(nullOk: false);
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.ApplicationView(key: args.key, userType: args.userType),
        settings: data,
      );
    },
    _i6.PrivacyPolicyView: (data) {
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.PrivacyPolicyView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ApplicationViewArguments {
  const ApplicationViewArguments({
    this.key,
    required this.userType,
  });

  final _i7.Key? key;

  final _i8.UserType userType;

  @override
  String toString() {
    return '{"key": "$key", "userType": "$userType"}';
  }

  @override
  bool operator ==(covariant ApplicationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.userType == userType;
  }

  @override
  int get hashCode {
    return key.hashCode ^ userType.hashCode;
  }
}

extension NavigatorStateExtension on _i9.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLandingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.landingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToApplicationView({
    _i7.Key? key,
    required _i8.UserType userType,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.applicationView,
        arguments: ApplicationViewArguments(key: key, userType: userType),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPrivacyPolicyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.privacyPolicyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLandingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.landingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithApplicationView({
    _i7.Key? key,
    required _i8.UserType userType,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.applicationView,
        arguments: ApplicationViewArguments(key: key, userType: userType),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPrivacyPolicyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.privacyPolicyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
