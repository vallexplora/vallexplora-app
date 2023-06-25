import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/resources/repository.dart';
import 'package:vallexplora/src/models/sale_model.dart';
import 'package:vallexplora/src/blocs/bloc.dart';

class SalesBloc implements Bloc {
  final _repository = Repository();

  final _name = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _companyID = BehaviorSubject<String>();
  final _expirationDate = BehaviorSubject<Timestamp>();
  final _stackable = BehaviorSubject<bool>();
  final _city = BehaviorSubject<String>();

  Stream<String> get name => _name.stream;
  Stream<String> get description => _description.stream;
  Stream<String> get companyID => _companyID.stream;
  Stream<Timestamp> get expirationDate => _expirationDate.stream;
  Stream<bool> get stackable => _stackable.stream;
  Stream<String> get city => _city.stream;

  Function(String) get changeName => _name.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changeCompanyID => _companyID.sink.add;
  Function(Timestamp) get changeExpirationDate => _expirationDate.sink.add;
  Function(bool) get changeStackable => _stackable.sink.add;
  Function(String) get changeCity => _city.sink.add;

  Stream<QuerySnapshot> salesList() => _repository.salesList();

  Future<List<SaleModel>> convertToFuture(List<DocumentSnapshot> docs) async {
    List<SaleModel> sales = [];

    for (var doc in docs) {
      SaleModel saleModel = await SaleModel.fromDocument(doc);
      sales.add(saleModel);
    }

    return sales;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (datePicked != null) {
      TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      DateTime? picked = timePicked != null
          ? DateTime(
              datePicked.year,
              datePicked.month,
              datePicked.day,
              timePicked.hour,
              timePicked.minute,
            )
          : DateTime.parse(datePicked.toString());

      changeExpirationDate(Timestamp.fromDate(picked));
    }
  }

  Future<void> addNewSale() => _repository.addNewSale(
        name: _name.value,
        description: _description.value,
        companyID: _companyID.value,
        expirationDate: _expirationDate.value,
        stackable: _stackable.value,
        city: _city.value,
      );

  @override
  void dispose() async {
    await _name.drain();
    _name.close();
    await _description.drain();
    _description.close();
    await _companyID.drain();
    _companyID.close();
    await _expirationDate.drain();
    _expirationDate.close();
    await _stackable.drain();
    _stackable.close();
    await _city.drain();
    _city.close();
  }
}
