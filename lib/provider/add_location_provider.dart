import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationProvider extends ChangeNotifier {
  String? pickedAddress;
  LatLng? pickedLatLng;

  void setPickedAddress(String? value) {
    pickedAddress = value;
    notifyListeners();
  }

  void setPickedLatLng(LatLng? value) {
    pickedLatLng = value;
    notifyListeners();
  }
}