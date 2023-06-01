import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

class LocationApi {
  static FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
  static FirebaseDatabase database =
      FirebaseDatabase.instanceFor(app: secondaryApp);
  static DatabaseReference ref = FirebaseDatabase.instance.ref("user");

  // save current location

  static void saveLocation(Position userLocation) async {
    await ref.set({
      "latitude": userLocation.latitude,
      "longitude": userLocation.longitude,
    });
  }
}
