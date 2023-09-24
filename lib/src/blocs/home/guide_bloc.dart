import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mtkt;
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/constants/colors.dart';
import 'package:vallexplora/src/resources/repository.dart';

import '../../constants/geo_jsons/vc.dart';

class GuideBloc implements Bloc {
  final _repository = Repository();

  final Location _location = Location();
  late GoogleMapController _mapController;

  final center = const LatLng(3.8009, -76.6413);

  get circles {
    return {
      Circle(
        circleId: const CircleId("1"),
        center: const LatLng(3.3418193443937687, -76.53016789666331),
        radius: 130,
        strokeColor: ColorResources.mayaBlue[500]!,
        strokeWidth: 3,
        fillColor: ColorResources.mayaBlue[500]!.withOpacity(0.2),
      ),
    };
  }

  Stream<QuerySnapshot> citiesList() => _repository.citiesList();

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _getJsonFile("assets/json/map_style.json")
        .then((value) => _setMapStyle(value, _mapController));

    _location.onLocationChanged.listen((location) {
      Logger log = Logger(level: Level.info);
      for (Circle circle in circles) {
        var center = circle.center;
        final distanceFromCenter = mtkt.SphericalUtil.computeDistanceBetween(
            mtkt.LatLng(center.latitude, center.longitude),
            mtkt.LatLng(location.latitude!, location.longitude!));
        if (distanceFromCenter > circle.radius) {
          // Outside
          log.i("Joven NO icesista, probablemente de la jave");
        } else {
          // Inside
          log.i("Joven icesista, el mejor amigo de Andy");
        }
      }
    });
  }

  void _setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  Future<String> _getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
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
          zoom: 19,
          tilt: 85,
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
