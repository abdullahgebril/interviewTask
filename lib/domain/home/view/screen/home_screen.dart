import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newtask/core/extension/media_values.dart';
import 'package:provider/provider.dart';

import '../../provider/google_map_provider .dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapProvider googleMapProvider;

  @override
  void initState() {
    super.initState();
    googleMapProvider = GoogleMapProvider();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await googleMapProvider.getMarkers();
      await googleMapProvider.requestUserCurrentLocation();
    });
  }
  @override
  void dispose() {
    
    super.dispose();
    googleMapProvider.positionStream.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoogleMapProvider>(create: (_) {
      return googleMapProvider;
    }, builder: (context, child) {
      return Scaffold(
        body: Consumer<GoogleMapProvider>(
          builder: (context, value, child) => SizedBox(
            height: context.height,
            width: context.width,
            child: GoogleMap(
              mapType: MapType.normal,
              minMaxZoomPreference: const MinMaxZoomPreference(8, 22),
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition: value.kGooglePlex,
              markers: Set<Marker>.of(value.markers),
              polylines: Set<Polyline>.of(value.polylines.values),
              compassEnabled: true,
              onTap: (argument) {},
              onMapCreated: (GoogleMapController controller) {
                googleMapProvider.mapController.complete(controller);
              },
              onCameraMove: (position) {},
            ),
          ),
        ),
      );
    });
    
  }
}
