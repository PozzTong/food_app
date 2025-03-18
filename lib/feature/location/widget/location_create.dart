import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class LocationCreate extends StatefulWidget {
  const LocationCreate({super.key});

  @override
  State<LocationCreate> createState() => _LocationCreateState();
}

class _LocationCreateState extends State<LocationCreate> {
  Marker? _currentLocationMarker;
  LatLng? _currentLocation;
  BitmapDescriptor? currentLocationIcon;
  BitmapDescriptor? selectedLocationIcon;
  final loc.Location location = loc.Location();
  final Completer<GoogleMapController> _mapController = Completer();
  String _address = "Fetching address...";

  @override
  void initState() {
    super.initState();
    _loadCustomIcons();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Location'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) async {
                    _mapController.complete(controller);
                    // String style = await DefaultAssetBundle.of(context)
                    //     .loadString('assets/map_style.json');
                    // // Apply the custom style to the map
                    // controller.setMapStyle(style);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation!,
                    zoom: 20,
                  ),
                  markers: {
                    if (_currentLocationMarker != null) _currentLocationMarker!,
                    if (selectedLocationIcon != null &&
                        _currentLocation != null)
                      Marker(
                        markerId: const MarkerId('selected_location'),
                        position: _currentLocation!,
                        icon: selectedLocationIcon!,
                      ),
                  },
                  onCameraMove: (CameraPosition position) async {
                    if (_currentLocation != null) {
                      await _getAddressFromLatLng(position.target);
                      setState(() {
                        _currentLocation = position.target;
                      });
                    }
                  },
                  onCameraIdle: () async {
                    if (_currentLocation != null) {
                      await _getAddressFromLatLng(_currentLocation!);
                    }
                  },
                ),
          Center(
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 50,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _currentLocation != null
                    ? "Location: \n$_address"
                    : "Fetching location...",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: FloatingActionButton(
              onPressed: getLocation,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getLocation() async {
    try {
      loc.LocationData? currentLocation = await getCurrentLocation();
      if (currentLocation != null) {
        setState(() {
          _currentLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _currentLocationMarker = Marker(
            markerId: const MarkerId('current_location'),
            position: _currentLocation!,
            icon: currentLocationIcon!,
          );
        });
        _cameraToPosition(_currentLocation!);
        await _getAddressFromLatLng(
            _currentLocation!); // Get the address after fetching the location
      } else {
        debugPrint("Location is null");
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  Future<void> _loadCustomIcons() async {
    currentLocationIcon = await createBitmapDescriptorFromIcon(
      icon: Icons.my_location,
      color: Colors.blue,
      size: 50.0,
    );
    selectedLocationIcon = await createBitmapDescriptorFromIcon(
      icon: Icons.location_on,
      color: Colors.red,
      size: 1.0,
    );
  }

  Future<BitmapDescriptor> createBitmapDescriptorFromIcon(
      {required IconData icon,
      required Color color,
      required double size}) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final TextPainter textPainter =
        TextPainter(textDirection: ui.TextDirection.ltr)
          ..text = TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(
              fontSize: size,
              fontFamily: icon.fontFamily,
              color: color,
            ),
          )
          ..layout();

    textPainter.paint(canvas, Offset.zero);
    final ui.Image image = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(pngBytes);
  }

  Future<loc.LocationData?> getCurrentLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: pos, zoom: 20);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address =
              "${place.subThoroughfare ?? ''} ${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}"
                  .trim();

          // _address =
          // "${place.street ?? ''} ${place.subThoroughfare ?? ''}".trim();
          // _address =
          //     "${place.street ?? ''} ${place.subThoroughfare ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}"
          //         .trim();
        });
      } else {
        setState(() {
          _address = "Address not found";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Error fetching address";
      });
      debugPrint("Error: $e");
    }
  }
}
