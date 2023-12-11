import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/models/sale_model.dart';
import 'package:vallexplora/src/ui/home_screens/feed/sale_card.dart';

import 'package:vallexplora/src/blocs/home/sales_bloc.dart';

class SalesViewTab extends StatefulWidget {
  const SalesViewTab({super.key});

  @override
  State<StatefulWidget> createState() => _SalesViewTabState();
}

class _SalesViewTabState extends State<SalesViewTab> {
  final _bloc = SalesBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bloc.salesList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          List<SaleModel> sales = _bloc.convertToList(docs);
          if (sales.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sales.length,
              itemBuilder: (context, index) {
                var sale = sales[index];
                return SaleCard(
                  name: sale.name,
                  description: sale.description,
                  companyName: sale.companyName,
                  end: sale.end,
                  start: sale.start,
                  requirement: sale.requirement,
                  requirementType: sale.requirementType,
                  city: sale.city,
                );
              },
            );
          } else {
            return const Center(
              child: Text('No hay promociones por el momento :('),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Ocurrió un error: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
