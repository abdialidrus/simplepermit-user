import 'package:flutter/material.dart';
import 'package:permit_repository/permit_repository.dart';
import 'package:simple_permit_user/counter/counter.dart';
import 'package:simple_permit_user/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({required this.permitRepository, super.key});

  final PermitRepository permitRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}
