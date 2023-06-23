import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/ui/home_screens/home_screen.dart';

import '../blocs/home/home_container_bloc.dart';
import 'home_screens/challenges_screen.dart';
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
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: StreamBuilder<int>(
          stream: _bloc.currentIndex,
          builder: (context, snapshot) {
            return NavigationBarTheme(
              data: NavigationBarThemeData(
                height: 80,
                backgroundColor: ColorResources.mayaBlue[100],
                indicatorColor: ColorResources.mayaBlue[200],
                iconTheme: MaterialStateProperty.resolveWith((state) {
                  if (state.contains(MaterialState.selected)) {
                    return IconThemeData(
                      color: ColorResources.mayaBlue[1200],
                      opticalSize: 64.0,
                    );
                  } else {
                    return IconThemeData(
                      color: ColorResources.mayaBlue[1200],
                    );
                  }
                }),
                labelTextStyle: MaterialStateProperty.resolveWith((state) {
                  if (state.contains(MaterialState.selected)) {
                    return TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: MaterialColor(
                        ColorResources.mayaBlue[1000]!.value,
                        ColorResources.mayaBlue,
                      ),
                    );
                  }
                  return TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: MaterialColor(
                      ColorResources.mayaBlue[1200]!.value,
                      ColorResources.mayaBlue,
                    ),
                  );
                }),
              ),
              child: NavigationBar(
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
            );
          }),
      body: StreamBuilder<int>(
        stream: _bloc.currentIndex,
        builder: (context, snapshot) {
          return _screens[snapshot.data != null ? snapshot.data! : 0];
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
