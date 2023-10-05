import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mtkt;
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/resources/repository.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class GuideBloc implements Bloc {
  final _repository = Repository();

  final _showARButton = BehaviorSubject<bool>();
  final _eventMarkers = BehaviorSubject.seeded(<MarkerId, Marker>{});
  final _pos = BehaviorSubject<LocationData>.seeded(
      LocationData.fromMap({"latitude": 3.8, "longitude": -76.6}));

  Stream<bool> get showARButton => _showARButton.stream;
  late Stream<List<DocumentSnapshot>> geoStream;
  Stream<Map<MarkerId, Marker>> get eventMarkers => _eventMarkers.stream;

  Function(bool) get changeShowARButton => _showARButton.sink.add;
  Function(Map<MarkerId, Marker>) get changeEventMarkers =>
      _eventMarkers.sink.add;

  final Location _location = Location();
  late GoogleMapController _mapController;
  final GeoFlutterFire _geo = GeoFlutterFire();
  final center = const LatLng(3.8009, -76.6413);
  Map<MarkerId, Marker> events = <MarkerId, Marker>{};
  LocationData _lastPos =
      LocationData.fromMap({"latitude": 3.8, "longitude": -76.6});
  final radius = 20.0; // km

  void _fetchPolygonsAndAreas(double rad) {
    geoStream = _pos.switchMap((pos) {
      var collectionReference = _repository.eventsListQuery();
      GeoFirePoint centerGeo =
          _geo.point(latitude: pos.latitude!, longitude: pos.longitude!);
      return _geo
          .collection(collectionRef: collectionReference)
          .within(center: centerGeo, radius: rad, field: 'eventJson.location');
    });
  }

  mtkt.LatLng _centroid(List<mtkt.LatLng> points) {
    // Calculate the area of the polygon

    double area = 0;
    for (int i = 0; i < points.length - 1; i++) {
      area += (points[i].latitude * points[i + 1].longitude -
              points[i + 1].latitude * points[i].longitude) /
          2;
    }

    // I literally do not understand this

    double cx = 0;
    double cy = 0;
    for (int i = 0; i < points.length - 1; i++) {
      mtkt.LatLng p1 = points[i];
      mtkt.LatLng p2 = points[i + 1];
      double areaContribution =
          (p1.latitude * p2.longitude - p2.latitude * p1.longitude) / 2;
      cx += (p1.latitude + p2.latitude) * areaContribution / 6;
      cy += (p1.longitude + p2.longitude) * areaContribution / 6;
    }

    return mtkt.LatLng(cx / area, cy / area);
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _location.getLocation().then((loc) => _pos.add(loc));
    _mapController = controller;
    _getJsonFile("assets/json/map_style.json")
        .then((value) => _setMapStyle(value, _mapController));
    _fetchPolygonsAndAreas(radius);
    _location.onLocationChanged.listen((location) {
      _pos.add(location);
      _lastPos = location;
      _fetchPolygonsAndAreas(radius);
    });
    geoStream.listen((List<DocumentSnapshot> documentList) {
      _updateMarkers(documentList);
    });
  }

  void _setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    events.clear();
    for (var document in documentList) {
      GeoPoint point = document["eventJson"]["location"]["geopoint"];
      double lat = point.latitude;
      double lng = point.longitude;
      String name = document["eventJson"]["name"];
      // String description = document["eventJson"]["description"];

      final marker = Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, lng),
      );

      events[marker.markerId] = marker;
    }
    changeEventMarkers(events);
  }

  Future<String> _getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  animateToUser() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _lastPos.latitude!,
            _lastPos.longitude!,
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

  @override
  Future<void> dispose() async {
    await _location.onLocationChanged.drain();
    _mapController.dispose();
    await geoStream.drain();
    await _eventMarkers.drain();
    _eventMarkers.close();
    await _pos.drain();
    _pos.close();
  }
}
