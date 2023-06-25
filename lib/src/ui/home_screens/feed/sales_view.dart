import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/models/sale_model.dart';
import 'package:vallexplora/src/ui/home_screens/feed/sale_card.dart';

import '../../../blocs/home/sales_bloc.dart';

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
          Future<List<SaleModel>> futureSales = _bloc.convertToFuture(docs);

          return FutureBuilder<List<SaleModel>>(
            future: futureSales,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<SaleModel> sales = snapshot.data ?? [];
                if (sales.isNotEmpty) {
                  return ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      var sale = sales[index];
                      return SaleCard(
                          name: sale.name,
                          description: sale.description,
                          companyID: sale.companyID,
                          expirationDate: sale.expirationDate,
                          stackable: sale.stackable,
                          place: sale.city);
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No hay promociones por el momento :('),
                  );
                }
              }
            },
          );
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
