import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/models/origin_place.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vallexplora/src/resources/repository.dart';

class RegisterPart2Bloc extends Bloc {
  final Repository _repository = Repository();

  final List<DropdownMenuItem<String>> originEntries =
      <DropdownMenuItem<String>>[];

  final _selectedOrigin = BehaviorSubject<String>();
  final _categoryFilters = BehaviorSubject<List<String>>();
  final _selectedImage = BehaviorSubject<String>();

  Stream<String> get selectedOrigin => _selectedOrigin.stream;
  Stream<List<String>> get categoryFilters => _categoryFilters.stream;
  Stream<String> get selectedImage => _selectedImage.stream;

  Function(String) get changeSelectedOrigin => _selectedOrigin.sink.add;
  Function(List<String>) get changeCategoryFilters => _categoryFilters.sink.add;
  Function(String) get changeSelectedImage => _selectedImage.sink.add;

  void initialize() {
    changeCategoryFilters([]);
    changeSelectedImage("");
    final user = _repository.getCurrentUser();
    if (user.providerData[0].providerId == "google.com") {
      changeSelectedImage(user.photoURL!);
    }
  }

  modifyCategoryFilters(String category) {
    categoryFilters.listen((event) {
      if (event.contains(category)) {
        event.remove(category);
      } else if (event.length != 3) {
        event.add(category);
      }
    });
  }

  void initializeOriginDropDown(context) {
    originEntries.clear();
    originEntries.add(DropdownMenuItem<String>(
      value: AppLocalizations.of(context)!.sRegister2SelectOne,
      child: Text(AppLocalizations.of(context)!.sRegister2SelectOne),
    ));
    changeSelectedOrigin(AppLocalizations.of(context)!.sRegister2SelectOne);
    for (final OriginPlaceLabel department in OriginPlaceLabel.values) {
      var label = department.name;
      if (department.id == "world") {
        label = AppLocalizations.of(context)!.sRegister2WorldLabel;
      } else if (department.id == "colombia") {
        label = AppLocalizations.of(context)!.sRegister2ColombiaLabel;
      }
      originEntries.add(DropdownMenuItem<String>(
        value: label,
        child: Text(label),
      ));
    }
  }

  void finishRegistration() {
    _repository.addUserMetaData(_categoryFilters.value,
        OriginPlaceLabel.idByName(_selectedOrigin.value), _selectedImage.value);
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    changeSelectedImage(returnedImage.path);
  }

  @override
  Future<void> dispose() async {
    await _selectedOrigin.drain();
    _selectedOrigin.close();
    await _categoryFilters.drain();
    _categoryFilters.close();
    await _selectedImage.drain();
    _selectedImage.close();
  }
}
