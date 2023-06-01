import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newtask/core/api/home_api/home_api.dart';
import 'package:newtask/core/exception/api_exception.dart';
import 'package:newtask/core/widget/flutter_toast.dart';
import 'package:newtask/domain/home/data/model/marker_model.dart';

class GoogleMapProvider extends ChangeNotifier {
  final List<Marker> markers = <Marker>[];
  late final Completer<GoogleMapController> mapController = Completer();
  bool isLoading = false;
  List<MarkerData> markerData = [];
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  late StreamSubscription<Position> positionStream;
  List<PolylineWayPoint> polylineWayPoints = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Position? _currentPosition;
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 11,
  );

  Future<void> getMarkers() async {
    _setLoading(true);
    try {
      final markerResponse = await HomeApi.getMarkers();

      markerData = markerResponse.data;
      drawMarkerOnMpa(markerData);
      _setLoading(false);
    } on ApiException catch (e) {
      // show toast with error message
      showFlutterToast(msg: e.error);
      _setLoading(false);
    }
  }

  Future<void> drawMarkerOnMpa(List<MarkerData> allMarkers) async {
    for (var marker in allMarkers) {
      LatLng start =
          LatLng(double.parse(marker.lat), double.parse(marker.longt));
      addMarker(start);
    }
  }

  Future<void> getUserCurrentLocation() async {
    requestAccessLocationPermission(getCurrentLocation);
  }

  void requestAccessLocationPermission(Function onPermissionGranted) async {
    await Geolocator.requestPermission().then((value) {
      onPermissionGranted();
    }).onError((error, stackTrace) async {
      requestAccessLocationPermission(onPermissionGranted);
    });
  }

  Future<void> getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => setCurrentLocation(position));
  }

  void streamUSerLocation() {
    positionStream =
        Geolocator.getPositionStream().listen((Position position) async {
      kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
      setCurrentLocation(position);
    });
  }

  void setCurrentLocation(Position position) {
    _currentPosition = position;
    
  }

  void _setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Position? get currentPosition => _currentPosition;

  addMarker(latLng) {
    markers.add(Marker(
      consumeTapEvents: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
    ));
    if (markers.length > 1) {
      getDirections(markers);
    }
  }

// This functions gets real road polyline routes
  getDirections(List<Marker> markers) async {
    for (var i = 0; i < markers.length; i++) {
      if (i + 1 >= markers.length) break;
      polylineWayPoints.add(PolylineWayPoint(
          location:
              "${markers[i].position.latitude.toString()},${markers[i].position.longitude.toString()}",
          stopOver: true));

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyB4Ti-TjouJnZQE3JWF6fDdDsf1FWhKTC8',
        PointLatLng(
            markers[i].position.latitude, markers[i].position.longitude),
        PointLatLng(markers[i + 1].position.latitude,
            markers[i + 1].position.longitude),
        travelMode: TravelMode.driving,
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.errorMessage);
      }
    }

    addPolyLine(polylineCoordinates);
    notifyListeners();
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
  }
}
