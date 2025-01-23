// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class MyMapPage extends StatefulWidget {
//   const MyMapPage({super.key});

//   @override
//   State<MyMapPage> createState() => _MyMapPageState();
// }

// class _MyMapPageState extends State<MyMapPage> {

//   Location _locationController = new Location();
//   LatLng? _currentPosition = null;
//   static const LatLng _pUganda = LatLng(1.3733, 32.2903);
//   static const LatLng _pBankBuilging = LatLng(1.4303, 32.3913);
  

//   @override
//   void initState(){
//     super.initState();
//     getLocationUpdates();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: GoogleMap(initialCameraPosition: const CameraPosition(target: _pUganda,zoom: 10),
//     markers: {
//       const Marker(markerId: MarkerId("_currentLocation"),icon: BitmapDescriptor.defaultMarker,position: _pUganda
// ),
// const Marker(markerId: MarkerId("_sourceLocation"),icon: BitmapDescriptor.defaultMarker,position: _pBankBuilging
// ),
//     },
//     ),
    
//     );
//   }

//   Future<void> getLocationUpdates() async{
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (_serviceEnabled){
//       _serviceEnabled = await _locationController.requestService();
//     }else{
//       return;
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if(_permissionGranted == PermissionStatus.denied){
//       _permissionGranted = await _locationController.requestPermission();
//       if(_permissionGranted != PermissionStatus.granted){
//         return;

        
//       }
//           _locationController.onLocationChanged.listen(LocationData currentLocation){
//       if (currentLocation.latitude != null && currentLocation.longitude != null){
//         setState(() {
//           _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           print(_currentPosition);
//         });
//       }
//     };

      
//     }


  
//   }
  
// }

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
  static const LatLng _pBankBuilding = LatLng(1.4303, 32.3913);

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null? const Center(
        child: Text("Loading..."),
      ):GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _pUganda,
          zoom: 10,
        ),
        markers: {
          if (_currentPosition != null)
            Marker(
              markerId: const MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _currentPosition!,
            ),
          const Marker(
            markerId: MarkerId("_sourceLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _pBankBuilding,
          ),
        },
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check and request location service
    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check and request location permission
    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Listen to location updates
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
