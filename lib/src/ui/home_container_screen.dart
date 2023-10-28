import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vallexplora/src/ui/home_screens/feed/home_screen.dart';
import 'package:vallexplora/src/ui/profile/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';
import '../blocs/home/home_container_bloc.dart';
import 'home_screens/challenges/challenges_screen.dart';
import 'home_screens/guide/guide_screen.dart';
import 'home_screens/markers_screen.dart';

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
    MarkersScreen(),
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
              backgroundColor: lightScheme.surfaceContainer,
              leading: IconButton(
                icon: const Icon(Icons.logout_rounded),
                onPressed: () {
                  _bloc.logout().then((value) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    return Fluttertoast.showToast(
                        msg: AppLocalizations.of(context)!.gBye,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                },
              ),
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
                  icon: const Icon(Icons.location_on_outlined),
                  selectedIcon: const Icon(Icons.location_on),
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
}
