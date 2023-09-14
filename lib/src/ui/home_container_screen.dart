import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vallexplora/src/ui/home_screens/feed/home_screen.dart';
import 'package:vallexplora/src/ui/profile/profile_screen.dart';

import '../blocs/home/home_container_bloc.dart';
import 'home_screens/challenges/challenges_screen.dart';
import 'home_screens/guide_screen.dart';
import 'home_screens/markers_screen.dart';

class HomeContainerScreen extends StatefulWidget {
  const HomeContainerScreen({super.key});

  @override
  State<HomeContainerScreen> createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  final _bloc = HomeContainerBloc();
  final _screens = const [
    HomeScreen(),
    GuideScreen(),
    ChallengesScreen(),
    MarkersScreen(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _bloc.currentIndex,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.logout_rounded),
                onPressed: () {
                  _bloc.logout().then((value) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    return Fluttertoast.showToast(
                        msg: "¡Chao!",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    )
                  },
                )
              ],
            ),
            bottomNavigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: "Inicio",
                ),
                NavigationDestination(
                  icon: Icon(Icons.map_outlined),
                  selectedIcon: Icon(Icons.map_rounded),
                  label: "Guía",
                ),
                NavigationDestination(
                  icon: Icon(Icons.workspace_premium_outlined),
                  selectedIcon: Icon(Icons.workspace_premium_rounded),
                  label: "Desafíos",
                ),
                NavigationDestination(
                  icon: Icon(Icons.location_on_outlined),
                  selectedIcon: Icon(Icons.location_on),
                  label: "Marcadores",
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

  @override
  void dispose() {
    super.dispose();
  }
}
