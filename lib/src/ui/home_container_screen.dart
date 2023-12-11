import 'package:flutter/material.dart';
import 'package:vallexplora/src/ui/home_screens/feed/home_screen.dart';
import 'package:vallexplora/src/ui/profile/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';
import '../blocs/home/home_container_bloc.dart';
import 'home_screens/challenges/challenges_screen.dart';
import 'home_screens/guide/guide_screen.dart';
import 'home_screens/leaderboard/leaderboard_screen.dart';

class HomeContainerScreen extends StatefulWidget {
  final int? initialScreen;

  const HomeContainerScreen({super.key, this.initialScreen});

  @override
  State<HomeContainerScreen> createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  final _bloc = HomeContainerBloc();
  late int? initialScreen;

  final _screens = const [
    HomeScreen(),
    GuideScreen(),
    ChallengesScreen(),
    LeaderboardScreen(),
  ];
  @override
  void initState() {
    super.initState();
    initialScreen = widget.initialScreen;
    _bloc.requestPermissions();
    if (initialScreen != null) {
      _bloc.changeIndex(initialScreen!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _bloc.currentIndex,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(titles(context)[snapshot.data ?? 0]),
              backgroundColor: lightScheme.surfaceContainer,
              actions: [
                IconButton(
                  icon: const Icon(Icons.account_circle_rounded),
                  onPressed: () => {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      clipBehavior: Clip.none,
                      builder: (context) => const ProfileScreen(),
                    ),
                  },
                ),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home_rounded),
                  label: AppLocalizations.of(context)!.gHome,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.map_outlined),
                  selectedIcon: const Icon(Icons.map_rounded),
                  label: AppLocalizations.of(context)!.gGuide,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.workspace_premium_outlined),
                  selectedIcon: const Icon(Icons.workspace_premium_rounded),
                  label: AppLocalizations.of(context)!.gChallenges,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.emoji_events_outlined),
                  selectedIcon: const Icon(Icons.emoji_events),
                  label: AppLocalizations.of(context)!.gLeaderboard,
                ),
              ],
              selectedIndex: snapshot.data != null ? snapshot.data! : 0,
              onDestinationSelected: (newIndex) {
                _bloc.changeIndex(newIndex);
              },
            ),
            body: IndexedStack(
              index: snapshot.data != null ? snapshot.data! : 0,
              children: _screens,
            ),
          );
        });
  }

  titles(BuildContext context) => [
        AppLocalizations.of(context)!.gHome,
        AppLocalizations.of(context)!.gGuide,
        AppLocalizations.of(context)!.gChallenges,
        AppLocalizations.of(context)!.gLeaderboard,
      ];
}
