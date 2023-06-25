import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/constants/text_strings.dart';
import 'package:vallexplora/src/ui/home_screens/feed/events_view.dart';
import 'package:vallexplora/src/ui/home_screens/feed/new_event_screen.dart';
import 'package:vallexplora/src/ui/home_screens/feed/new_sale_screen.dart';
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
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _bloc.changeActiveTab(0);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _bloc.changeActiveTab(_tabController.index);
    });
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.event_outlined),
            text: StringResources.eventsTabTitle,
          ),
          Tab(
            icon: Icon(Icons.local_activity_outlined),
            text: StringResources.discountsTabTitle,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: ColorResources.mayaBlue[200],
              shadowColor: Colors.transparent,
              child: _tabBar,
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<int>(
            stream: _bloc.activeTabIndex,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FloatingActionButton(
                  heroTag:
                      snapshot.data == 0 ? "homeEventsFAB" : "homeSalesFAB",
                  child: Icon(snapshot.data == 0
                      ? Icons.event_outlined
                      : Icons.local_activity_outlined),
                  onPressed: () {
                    snapshot.data == 0
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewEventScreen(),
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewSaleScreen(),
                            ),
                          );
                  },
                );
              } else {
                return FloatingActionButton(
                  heroTag: "homeEmptyFAB",
                  child: const Icon(Icons.access_time_outlined),
                  onPressed: () {},
                );
              }
            }),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
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
