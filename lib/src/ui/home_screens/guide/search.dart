import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/guide/search_bloc.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/constants/sizes.dart';
import 'package:vallexplora/src/ui/home_screens/guide/filters.dart';
import 'package:vallexplora/src/ui/home_screens/guide/query_results.dart';
import 'package:vallexplora/src/ui/home_screens/guide/recommended.dart';
import 'package:vallexplora/src/ui/home_screens/guide/search_bar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _bloc = SearchBloc();

  @override
  void initState() {
    _bloc.initiallize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget makeDismissable({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );

    return makeDismissable(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(SizeResources.defaultBorderRadius)),
          ),
          padding: const EdgeInsets.all(
            SizeResources.defaultPadding,
          ),
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: ListView(
              physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast,
              ),
              controller: controller,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        height: 4,
                        width: 56,
                        color: neutralRef.value70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                SearchBarWrapper(
                  searchController: _bloc.searchController,
                  changeSearchValue: _bloc.changeSearchValue,
                  changeShowFilters: _bloc.changeShowFilters,
                  showFilters: _bloc.showFilters,
                ),
                Filters(
                  modifyCategoryFilters: _bloc.modifyCategoryFilters,
                  modifyClassificationFilters:
                      _bloc.modifyClassificationFilters,
                  modifyRegionFilters: _bloc.modifyRegionFilters,
                  categoryFilters: _bloc.categoryFilters,
                  regionFilters: _bloc.regionFilters,
                  classificationFilters: _bloc.classificationFilters,
                  showFilters: _bloc.showFilters,
                ),
                const SizedBox(
                  height: 16,
                ),
                Recommended(
                  searchValue: _bloc.searchValue,
                ),
                const SizedBox(
                  height: 16,
                ),
                QueryResults(
                  searchValue: _bloc.searchValue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
