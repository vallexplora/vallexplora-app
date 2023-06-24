import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/text_strings.dart';
import 'package:vallexplora/src/ui/home_screens/feed/events_view.dart';
import 'package:vallexplora/src/ui/home_screens/feed/sales_view.dart';

import '../../../blocs/home/home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _bloc = HomeScreenBloc();
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _bloc.changeActiveTab(0);
    _controller = TabController(length: 2, vsync: this);
    _controller?.addListener(() {
      if (_controller!.indexIsChanging) {
        _bloc.changeActiveTab(_controller!.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: StreamBuilder<int>(
            stream: _bloc.activeTabIndex,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FloatingActionButton(
                  child: Icon(snapshot.data == 0
                      ? Icons.event_outlined
                      : Icons.discount_outlined),
                  onPressed: () {},
                );
              } else {
                return FloatingActionButton(
                  onPressed: () {},
                );
              }
            }),
        body: const Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.event_outlined),
                  text: StringResources.eventsTabTitle,
                ),
                Tab(
                  icon: Icon(Icons.discount_outlined),
                  text: StringResources.eventsTabTitle,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  EventsViewTab(),
                  SalesViewTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
