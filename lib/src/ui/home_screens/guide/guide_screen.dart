import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vallexplora/src/blocs/home/guide_bloc.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  final _bloc = GuideBloc();

  @override
  void initState() {
    _bloc.changeShowARButton(false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: lightScheme.surfaceContainerHigh,
            foregroundColor: Theme.of(context).colorScheme.primary,
            heroTag: "find_center",
            mini: true,
            onPressed: () => _bloc.animateToCenter(),
            child: const Icon(
              Icons.center_focus_strong,
            ),
          ),
          FloatingActionButton(
            backgroundColor: lightScheme.surfaceContainerHigh,
            foregroundColor: Theme.of(context).colorScheme.primary,
            heroTag: "find_user",
            mini: true,
            onPressed: () => _bloc.animateToUser(),
            child: const Icon(
              Icons.my_location_rounded,
            ),
          ),
          // const SizedBox(
          //   height: SizeResources.smallHeight,
          // ),
          // FloatingActionButton(
          //   onPressed: () {
          //     showModalBottomSheet(
          //       context: context,
          //       isScrollControlled: true,
          //       backgroundColor: Colors.transparent,
          //       clipBehavior: Clip.none,
          //       builder: (context) => const Search(),
          //     );
          //   },
          //   child: const Icon(
          //     Icons.search,
          //   ),
          // ),
          StreamBuilder<bool>(
            stream: _bloc.showARButton,
            builder: (builder, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      FloatingActionButton(
                        heroTag: "ar_view",
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const ARView(),
                          //   ),
                          // );
                        },
                        child: const Icon(
                          Icons.view_in_ar_rounded,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox(
                    width: 16,
                  );
                }
              } else {
                return const SizedBox(
                  width: 16,
                );
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder<Map<PolygonId, Polygon>>(
              stream: _bloc.polygonAreas,
              builder: (context, snapshot) {
                return GoogleMap(
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
                  polygons: (snapshot.data ?? {}).values.toSet(),
                );
              }),
        ],
      ),
    );
  }
}
