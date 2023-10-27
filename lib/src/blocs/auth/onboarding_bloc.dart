import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';

class OnboardingBloc extends Bloc {
  final controller = PageController();

  final _page = BehaviorSubject<int>.seeded(0);

  Stream<int> get page => _page.stream;

  Function(int) get changePage => _page.sink.add;

  Map<int, Color> colors(context) => {
        0: Theme.of(context).primaryColor,
        1: Theme.of(context).colorScheme.surface,
        2: lightScheme.primaryFixed,
      };
  Map<int, Color> foregrounds(context) => {
        0: Theme.of(context).colorScheme.onPrimary,
        1: Theme.of(context).colorScheme.onSurface,
        2: lightScheme.onPrimaryFixed,
      };

  Map<int, Color> tonals(context) => {
        0: Theme.of(context).colorScheme.secondaryContainer,
        1: Theme.of(context).colorScheme.primary,
        2: Theme.of(context).colorScheme.primary,
      };

  Map<int, Color> tonalForegrounds(context) => {
        0: Theme.of(context).colorScheme.onSecondaryContainer,
        1: Theme.of(context).colorScheme.onPrimary,
        2: Theme.of(context).colorScheme.onPrimary,
      };

  void init() {}

  @override
  void dispose() {
    controller.dispose();
  }
}
