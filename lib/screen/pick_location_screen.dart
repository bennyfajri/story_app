import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:story_app/my_app.dart';
import 'package:story_app/provider/add_location_provider.dart';
import 'package:story_app/util/constant.dart';

import '../widgets/placemark_widget.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({
    super.key,
    required this.onAdded,
  });

  final VoidCallback onAdded;

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  final monas = const LatLng(-6.1753553, 106.8270458);
  late GoogleMapController mapController;
  late Set<Marker> markers = {};
  geo.Placemark? placemark;
  LatLng? pickedLatLng;
  String? pickedAddress;

  @override
  Widget build(BuildContext context) {
    final addLocationProvider = context.watch<AddLocationProvider>();

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                zoom: 13,
                target: addLocationProvider.pickedLatLng ?? monas,
              ),
              markers: markers,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) async {
                final latLng = addLocationProvider.pickedLatLng ?? monas;
                final info = await geo.placemarkFromCoordinates(
                  latLng.latitude,
                  latLng.longitude,
                );
                final place = info[0];
                final street = place.street!;
                final address =
                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                setState(() {
                  placemark = place;
                  pickedAddress = "$street, $address";
                  pickedLatLng = latLng;
                });
                defineMarker(latLng, street, address);

                setState(() {
                  mapController = controller;
                });
              },
              onTap: onTapGoogleMap,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: onMyLocationButtonPress,
                child: const Icon(Icons.my_location),
              ),
            ),
            if (placemark == null)
              const SizedBox()
            else
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: PlacemarkWidget(
                  placemark: placemark!,
                  onSelected: () {
                    if (pickedLatLng != null) {
                      final locationProvider = Provider.of<AddLocationProvider>(
                        context,
                        listen: false,
                      );
                      locationProvider.setPickedLatLng(pickedLatLng);
                      locationProvider.setPickedAddress(pickedAddress);

                      widget.onAdded();
                    } else {
                      showSnackbar(
                        context: context,
                        message: appLocale.add_location_error,
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location services is not available");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
      pickedAddress = "$street, $address";
      pickedLatLng = latLng;
    });

    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onTapGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
      pickedAddress = "$street, $address";
      pickedLatLng = latLng;
    });

    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }
}
