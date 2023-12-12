import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/home/places_bloc.dart';
import 'package:vallexplora/src/models/place_model.dart';
import 'package:vallexplora/src/ui/home_screens/feed/place_card.dart';

class PlacesViewTab extends StatefulWidget {
  const PlacesViewTab({super.key});

  @override
  State<PlacesViewTab> createState() => _PlacesViewTabState();
}

class _PlacesViewTabState extends State<PlacesViewTab> {
  final _bloc = PlacesBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bloc.placesList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          Future<List<PlaceModel>> futureEvents = _bloc.convertToFuture(docs);

          return FutureBuilder<List<PlaceModel>>(
            future: futureEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<PlaceModel> places = snapshot.data ?? [];
                if (places.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      var place = places[index];
                      return PlaceCard(
                        name: place.name,
                        shortDescription: place.shortDescription,
                        fee: place.fee,
                        climate: place.climate,
                        closeTime: place.closeTime,
                        openTime: place.openTime,
                        cityName: place.cityName,
                        imageUrl: place.imageUrl,
                        imageAlt: place.imageAlt,
                        enabled: place.enabled,
                        hasAR: place.hasAugmentedReality,
                        area: place.area,
                        arText: place.arText,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No hay eventos por el momento :('),
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
