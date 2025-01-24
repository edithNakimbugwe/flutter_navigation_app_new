import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMapPage extends StatefulWidget {
  const MyMapPage({super.key});

  @override
  State<MyMapPage> createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  final Location _locationController = Location();
  LatLng? _currentPosition;
  static const LatLng _pUganda = LatLng(1.3733, 32.2903);

  static const LatLng _jointClinicalResearchCenter = LatLng(1.4303, 22.566667);
  static const LatLng _stFrancisNsambyaHospital = LatLng(0.30155, 32.58609);
  static const LatLng _mulagoHospital = LatLng(0.3392, 32.57618);
  static const LatLng _mengoHospital = LatLng(0.31278, 32.55833);
  static const LatLng _mildmayCenter = LatLng(0.22658, 32.5507);
  static const LatLng _bankOfUgandaClinic = LatLng(0.31379, 32.58038);
  static const LatLng _caseClinic = LatLng(0.3244, 32.5750);
  static const LatLng _africanAirRescue = LatLng(0.22658, 32.5507);
  static const LatLng _ugandaNationalMedicalStore = LatLng(0.305289, 32.611112);
  static const LatLng _victoriaMedicalCenter = LatLng(0.05538, 32.46468);
  static const LatLng _mbararaRegionalHospital = LatLng(-0.61677, 30.65841);
  static const LatLng _masakaRegionalHospital = LatLng(-0.329444, 31.734444);
  static const LatLng _kabaleRegionalHospital = LatLng(-1.25105, 29.98899);
  static const LatLng _guluHospital = LatLng(2.777778, 32.297778);

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _pUganda,
                zoom: 13,
              ),
              markers: {
                if (_currentPosition != null)
                  Marker(
                    markerId: const MarkerId("_currentLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentPosition!,
                    infoWindow: const InfoWindow(title: "Your Location"),
                  ),
                const Marker(
                  markerId: MarkerId("_jointClinicalResearchCenter"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _jointClinicalResearchCenter,
                  infoWindow: InfoWindow(title: "Joint Clinical Research Center"),
                ),
                const Marker(
                  markerId: MarkerId("_stFrancisNsambyaHospital"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _stFrancisNsambyaHospital,
                  infoWindow: InfoWindow(title: "St. Francis Nsambya Hospital"),
                ),
                const Marker(
                  markerId: MarkerId("_mulagoHospital"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _mulagoHospital,
                  infoWindow: InfoWindow(title: "Mulago Hospital"),
                ),
                const Marker(
                  markerId: MarkerId("_mengoHospital"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _mengoHospital,
                  infoWindow: InfoWindow(title: "Mengo Hospital"),
                ),
                const Marker(
                  markerId: MarkerId("_mildmayCenter"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _mildmayCenter,
                  infoWindow: InfoWindow(title: "Mildmay Center"),
                ),
                const Marker(
                  markerId: MarkerId("_bankOfUgandaClinic"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _bankOfUgandaClinic,
                  infoWindow: InfoWindow(title: "Bank of Uganda Clinic"),
                ),
                const Marker(
                  markerId: MarkerId("_caseClinic"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _caseClinic,
                  infoWindow: InfoWindow(title: "Case Clinic"),
                ),
                const Marker(
                  markerId: MarkerId("_africanAirRescue"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _africanAirRescue,
                  infoWindow: InfoWindow(title: "African Air Rescue"),
                ),
                const Marker(
                  markerId: MarkerId("_ugandaNationalMedicalStore"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _ugandaNationalMedicalStore,
                  infoWindow: InfoWindow(title: "Uganda National Medical Store"),
                ),
                const Marker(
                  markerId: MarkerId("_victoriaMedicalCenter"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _victoriaMedicalCenter,
                  infoWindow: InfoWindow(title: "Victoria Medical Center"),
                ),
                const Marker(
                  markerId: MarkerId("_mbararaRegionalHospital"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _mbararaRegionalHospital,
                  infoWindow: InfoWindow(title: "Mbarara Regional Hospital"),
                ),
                const Marker(
                  markerId: MarkerId("_masakaRegionalHospital"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _masakaRegionalHospital,
                  infoWindow: InfoWindow(title: "Masaka Regional Hospital"),
                ),
                const Marker(
                  markerId: MarkerId("_kabaleRegionalHospital"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _kabaleRegionalHospital,
                  infoWindow: InfoWindow(title: "Kabale Regional Hospital"),
                ),
                const Marker(
                  markerId: MarkerId("_guluHospital"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _guluHospital,
                  infoWindow: InfoWindow(title: "Gulu Hospital"),
                ),
              },
            ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          print("Current Position: $_currentPosition");
        });
      }
    });
  }
}
