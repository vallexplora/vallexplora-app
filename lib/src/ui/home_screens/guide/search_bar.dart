import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

class SearchBarWrapper extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) changeSearchValue;
  final Function(bool) changeShowFilters;
  final Stream<bool> showFilters;

  const SearchBarWrapper({
    super.key,
    required this.searchController,
    required this.changeSearchValue,
    required this.changeShowFilters,
    required this.showFilters,
  });

  @override
  State<SearchBarWrapper> createState() => _SearchBarWrapperState();
}

class _SearchBarWrapperState extends State<SearchBarWrapper> {
  late TextEditingController searchController;
  late Function(String) changeSearchValue;
  late Function(bool) changeShowFilters;
  late Stream<bool> showFilters;

  @override
  void initState() {
    super.initState();
    searchController = widget.searchController;
    changeSearchValue = widget.changeSearchValue;
    changeShowFilters = widget.changeShowFilters;
    showFilters = widget.showFilters;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: showFilters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 16,
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return CupertinoSearchTextField(
            placeholder: "Busca y filtra...",
            controller: searchController,
            prefixIcon: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: ButtonStyle(
                iconColor: MaterialStateProperty.all(
                  ColorResources.mayaBlue[500],
                ),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
            ),
            suffixIcon: Icon(
              Icons.tune,
              color: ColorResources.mayaBlue[500],
            ),
            onSuffixTap: () {
              changeShowFilters(!(snapshot.data ?? false));
            },
            suffixMode: OverlayVisibilityMode.always,
            decoration: BoxDecoration(
              color: ColorResources.twNeutral[100],
              borderRadius: const BorderRadius.all(
                Radius.circular(32),
              ),
              border: Border.all(
                color: ColorResources.twNeutral[400]!,
              ),
            ),
            suffixInsets:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            prefixInsets:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            onChanged: (value) {
              changeSearchValue(value);
            },
            onSubmitted: (_) {},
          );
        });
  }
}
