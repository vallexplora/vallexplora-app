import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/resources/repository.dart';

import '../../constants/geo_jsons/vc.dart';

class GuideBloc implements Bloc {
  final _repository = Repository();

  final Location _location = Location();
  late GoogleMapController _mapController;

  final center = const LatLng(3.8009, -76.6413);

  Stream<QuerySnapshot> citiesList() => _repository.citiesList();

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  animateToUser() async {
    var pos = await _location.getLocation();
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            pos.latitude!,
            pos.longitude!,
          ),
          zoom: 12,
        ),
      ),
    );
  }

  animateToCenter() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            center.latitude,
            center.longitude,
          ),
          zoom: 8.2,
        ),
      ),
    );
  }

  Set<Polygon> drawValle() {
    Set polygon = {};
    List<List<LatLng>> polygons = _addPoints([]);

    List addPolygon = [];
    for (int i = 0; i < polygons.length; i++) {
      var points = polygons[i];
      addPolygon.add(
        Polygon(
          polygonId: PolygonId('ValleDelCauca$i'),
          points: points,
          consumeTapEvents: true,
          strokeColor: ColorResources.mayaBlue[500]!,
          strokeWidth: 1,
          fillColor: ColorResources.mayaBlue[100]!,
        ),
      );
    }
    polygon.addAll(addPolygon);
    return Set<Polygon>.from(polygon);
  }

  List<List<LatLng>> _addPoints(List<List<LatLng>> polygons) {
    for (var i = 0; i < VC.landMasses.length; i++) {
      List<List<double>> polygon = VC.landMasses[i][0];
      List<LatLng> points = [];
      for (var j = 0; j < polygon.length; j++) {
        var ltlng = LatLng(polygon[j][1], polygon[j][0]);
        points.add(ltlng);
      }
      polygons.add(points);
    }
    return polygons;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
