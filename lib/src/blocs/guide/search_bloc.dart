import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/resources/repository.dart';
import 'package:vallexplora/src/ui/home_screens/guide/search_result_card.dart';

class SearchBloc implements Bloc {
  final _repository = Repository();

  final _searchValue = BehaviorSubject<String>();
  final _categoryFilters = BehaviorSubject<List<String>>();
  final _regionFilters = BehaviorSubject<List<String>>();
  final _classificationFilters = BehaviorSubject<List<String>>();
  final _recommended = BehaviorSubject<List<SearchResultCard>>();
  final _results = BehaviorSubject<List<String>>();
  final _showFilters = BehaviorSubject<bool>();

  Stream<String> get searchValue => _searchValue.stream;
  Stream<List<String>> get categoryFilters => _categoryFilters.stream;
  Stream<List<String>> get regionFilters => _regionFilters.stream;
  Stream<List<String>> get classificationFilters =>
      _classificationFilters.stream;
  Stream<List<SearchResultCard>> get recommended => _recommended.stream;
  Stream<List<String>> get results => _results.stream;
  Stream<bool> get showFilters => _showFilters.stream;

  Function(String) get changeSearchValue => _searchValue.sink.add;
  Function(List<String>) get changeCategoryFilters => _categoryFilters.sink.add;
  Function(List<String>) get changeRegionFilters => _regionFilters.sink.add;
  Function(List<String>) get changeClassificationFilters =>
      _classificationFilters.sink.add;
  Function(List<SearchResultCard>) get changeRecommended =>
      _recommended.sink.add;
  Function(List<String>) get changeResults => _results.sink.add;
  Function(bool) get changeShowFilters => _showFilters.sink.add;

  final TextEditingController searchController = TextEditingController();

  void initiallize() {
    changeCategoryFilters([]);
    changeClassificationFilters([]);
    changeRegionFilters([]);

    changeSearchValue("");
    changeShowFilters(false);

    changeResults([]);
  }

  modifyCategoryFilters(String category) {
    categoryFilters.listen((event) {
      if (event.contains(category)) {
        event.remove(category);
      } else {
        event.add(category);
      }
    });
  }

  modifyClassificationFilters(String classification) {
    classificationFilters.listen((event) {
      if (event.contains(classification)) {
        event.remove(classification);
      } else {
        event.add(classification);
      }
    });
  }

  modifyRegionFilters(String region) {
    regionFilters.listen((event) {
      if (event.contains(region)) {
        event.remove(region);
      } else {
        event.add(region);
      }
    });
  }

  @override
  void dispose() async {
    await _searchValue.drain();
    _searchValue.close();
    await _categoryFilters.drain();
    _categoryFilters.close();
    await _regionFilters.drain();
    _regionFilters.close();
    await _classificationFilters.drain();
    _classificationFilters.close();
    await _recommended.drain();
    _recommended.close();
    await _results.drain();
    _results.close();
    await _showFilters.drain();
    _showFilters.close();
  }
}
