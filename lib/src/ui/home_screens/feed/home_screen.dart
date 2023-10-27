import 'package:flutter/material.dart';
import 'package:vallexplora/src/ui/home_screens/feed/events_view.dart';
import 'package:vallexplora/src/ui/home_screens/feed/sales_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/blocs/home/home_screen_bloc.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';

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
        tabs: [
          Tab(
            icon: const Icon(Icons.event_outlined),
            text: AppLocalizations.of(context)!.gEvents,
          ),
          Tab(
            icon: const Icon(Icons.local_activity_outlined),
            text: AppLocalizations.of(context)!.gRewards,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: lightScheme.surfaceContainer,
              child: _tabBar,
            ),
          ),
        ),
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
