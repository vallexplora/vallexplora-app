import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mtkt;
import 'package:rxdart/rxdart.dart';
import 'package:vallexplora/src/blocs/bloc.dart';
import 'package:vallexplora/src/resources/repository.dart';
import 'package:vallexplora/src/ui/home_screens/feed/event_details_screen.dart';
import 'package:vallexplora/src/utils/theme/color_schemes.dart';

class GuideBloc implements Bloc {
  final _repository = Repository();

  final _showARButton = BehaviorSubject<bool>();
  final _eventMarkers = BehaviorSubject.seeded(<MarkerId, Marker>{});
  final _polygonAreas = BehaviorSubject.seeded(<PolygonId, Polygon>{});
  final _pos = BehaviorSubject<LocationData>.seeded(
      LocationData.fromMap({"latitude": 3.8, "longitude": -76.6}));

  Stream<bool> get showARButton => _showARButton.stream;
  Stream<Map<MarkerId, Marker>> get eventMarkers => _eventMarkers.stream;
  Stream<Map<PolygonId, Polygon>> get polygonAreas => _polygonAreas.stream;

  Stream<QuerySnapshot> eventsList() => _repository.eventsList();

  Function(bool) get changeShowARButton => _showARButton.sink.add;
  Function(Map<MarkerId, Marker>) get changeEventMarkers =>
      _eventMarkers.sink.add;
  Function(Map<PolygonId, Polygon>) get changePolygonAreas =>
      _polygonAreas.sink.add;

  late BuildContext _context;
  final Location _location = Location();
  late GoogleMapController _mapController;
  final center = const LatLng(3.8009, -76.6413);
  Map<MarkerId, Marker> events = <MarkerId, Marker>{};
  Map<PolygonId, Polygon> polygons = <PolygonId, Polygon>{};
  LocationData _lastPos =
      LocationData.fromMap({"latitude": 3.8, "longitude": -76.6});
  final radius = 20.0; // km
  Logger l = Logger(level: Level.info);

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _location.getLocation().then((loc) => _pos.add(loc));
    _mapController = controller;
    _getJsonFile("assets/json/map_style.json")
        .then((value) => _setMapStyle(value, _mapController));
    eventsList().listen((event) {
      polygons.clear();
      for (var docSnap in event.docs) {
        List<dynamic> locationField = docSnap["location"];
        String id = docSnap.id;
        String name = docSnap["name"];
        String description = docSnap["description"];
        final List<LatLng> polyPoints = [];

        for (var point in locationField) {
          final geoPoint = point["geoPoint"] as GeoPoint;
          LatLng geoPointLL = LatLng(geoPoint.latitude, geoPoint.longitude);
          polyPoints.add(geoPointLL);
        }

        Polygon newPolygon = Polygon(
          polygonId: PolygonId(id),
          points: polyPoints,
          fillColor: lightScheme.primary.withAlpha(64),
          strokeColor: lightScheme.primary,
          strokeWidth: 2,
          consumeTapEvents: true,
          onTap: () => {
            Navigator.of(_context).push(
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(
                  name: name,
                  description: description,
                  entryFee: docSnap["entryFee"],
                  startDate: (docSnap["start"] as Timestamp).toDate(),
                  city: docSnap["city"],
                  eventType: docSnap["eventType"],
                  endDate: (docSnap["end"] as Timestamp).toDate(),
                  imagePath: docSnap["imagePath"],
                  hasAR: docSnap["hasAugmentedReality"],
                ),
              ),
            ),
          },
        );

        polygons[newPolygon.polygonId] = newPolygon;
      }
      changePolygonAreas(polygons);
    });
    _location.onLocationChanged.listen((location) {
      _pos.add(location);
      _lastPos = location;
    });
    polygonAreas.listen((events) {
      _showARButton.add(false);
      for (Polygon event in events.values) {
        if (isWithinPolygon(event)) {
          _showARButton.add(true);
          break;
        }
      }
    });
  }

  void _setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  bool isWithinPolygon(Polygon polygon) {
    if (mtkt.PolygonUtil.containsLocation(
        mtkt.LatLng(_lastPos.latitude!, _lastPos.longitude!),
        polygon.points
            .map((e) => mtkt.LatLng(e.latitude, e.longitude))
            .toList(),
        false)) {
      _showARButton.add(true);
      return true;
    }
    return false;
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
    await _eventMarkers.drain();
    _eventMarkers.close();
    await _pos.drain();
    _pos.close();
  }
}
