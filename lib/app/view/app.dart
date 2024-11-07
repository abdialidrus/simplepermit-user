import 'package:flutter/material.dart';
import 'package:permit_repository/permit_repository.dart';
import 'package:simple_permit_user/home/home.dart';
import 'package:simple_permit_user/l10n/l10n.dart';
import 'package:simple_permit_user/theme/theme.dart';

class App extends StatelessWidget {
  const App({required this.permitRepository, super.key});

  final PermitRepository permitRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: PermitAppTheme.light,
      darkTheme: PermitAppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
