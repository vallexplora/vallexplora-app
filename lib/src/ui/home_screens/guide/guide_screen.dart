import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vallexplora/src/blocs/home/guide_bloc.dart';
import 'package:vallexplora/src/constants/sizes.dart';
import 'package:vallexplora/src/ui/home_screens/guide/search.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  final _bloc = GuideBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "find_center",
            mini: true,
            onPressed: () => _bloc.animateToCenter(),
            child: const Icon(
              Icons.center_focus_strong,
            ),
          ),
          FloatingActionButton(
            heroTag: "find_user",
            mini: true,
            onPressed: () => _bloc.animateToUser(),
            child: const Icon(
              Icons.my_location_rounded,
            ),
          ),
          const SizedBox(
            height: SizeResources.smallHeight,
          ),
          FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                clipBehavior: Clip.none,
                builder: (context) => const Search(),
              );
            },
            child: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _bloc.citiesList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                GoogleMap(
                  compassEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _bloc.center,
                    zoom: 8.2,
                  ),
                  onMapCreated: _bloc.onMapCreated,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: false,
                  cameraTargetBounds: CameraTargetBounds(
                    LatLngBounds(
                      northeast: const LatLng(4.5009, -76.0413),
                      southwest: const LatLng(3.1009, -77.2413),
                    ),
                  ),
                  buildingsEnabled: true,
                  indoorViewEnabled: true,
                  circles: _bloc.circles,
                ),
              ],
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
      ),
    );
  }
}
