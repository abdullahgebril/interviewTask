import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newtask/core/api/home_api/home_api.dart';
import 'package:newtask/core/api/location/LocationApi.dart';
import 'package:newtask/core/exception/api_exception.dart';
import 'package:newtask/core/widget/flutter_toast.dart';
import 'package:newtask/domain/home/data/model/marker_model.dart';

class GoogleMapProvider extends ChangeNotifier {
  // Variables
  bool isLoading = false;

  // UI
  final List<Marker> markers = <Marker>[];
  late final Completer<GoogleMapController> mapController = Completer();
  List<MarkerData> markerData = [];
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 11,
  );
  List<PolylineWayPoint> polylineWayPoints = [];
  PolylinePoints polylinePoints = PolylinePoints();

  // Objects
  late StreamSubscription<Position> positionStream;
  Position? _currentPosition;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
   
  );

//provider Function

  Future<void> getMarkers() async {
    _setLoading(true);
    try {
      final markerResponse = await HomeApi.getMarkers();
      markerData = markerResponse.data;
      _setLoading(false);

      drawMarkerOnMap(markerData);
    } on ApiException catch (e) {
      // show toast with error message
      showFlutterToast(msg: e.error);
      _setLoading(false);
    }
  }

  Future<void> drawMarkerOnMap(List<MarkerData> allMarkers) async {
    for (var marker in allMarkers) {
      LatLng start =
          LatLng(double.parse(marker.lat), double.parse(marker.longt));
      addMarker(start);
    }
    getDirections(markers);
  }

  Future<void> requestUserCurrentLocation() async {
    requestAccessLocationPermission(listenToUserChangedLocation);
  }

  void requestAccessLocationPermission(Function onPermissionGranted) async {
    await Geolocator.requestPermission().then((value) {
      onPermissionGranted();
    }).onError((error, stackTrace) async {
      requestAccessLocationPermission(onPermissionGranted);
    });
  }



  void listenToUserChangedLocation() {
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) async {
      kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
      //  setCurrentLocation(position);
      LocationApi.saveLocation(position);
      LatLng latLng = LatLng(position.latitude, position.longitude) ;
      addMarkerById(latLng,"1");
      
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

  addMarker(latLng,[String? id ]) {
    markers.add(Marker(
      consumeTapEvents: true,
      markerId: MarkerId(id??latLng.toString()),
      position: latLng,
    ));
  }
  void addMarkerById(LatLng latLng , String id ){
    var markerIndex = markers.indexWhere((element) => element.markerId == id);
    if(markerIndex != -1 ){
      markers[markerIndex] = Marker(
      consumeTapEvents: true,
      markerId: MarkerId(latLng.toString()),
      position: latLng,
    );
    }else {
      addMarker(latLng);
    }
    notifyListeners();
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
        debugPrint(result.errorMessage);
      }
    }

    addPolyLine(polylineCoordinates);
    notifyListeners();
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
  }
}
