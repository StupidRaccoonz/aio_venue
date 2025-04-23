import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PlacePickerScreen extends StatefulWidget {
  @override
  _PlacePickerScreenState createState() => _PlacePickerScreenState();
}

class _PlacePickerScreenState extends State<PlacePickerScreen> {
  late GoogleMapController _mapController;
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pinController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LatLng _currentLatLng = LatLng(23.5880, 58.3829);
  String _address = "Fetching location...";
  bool _isFetchingAddress = false;
  bool _manualAddress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserLocation();
    });
  }

  /// Get user's current location
  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng newLocation = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentLatLng = newLocation;
    });

    _mapController.animateCamera(CameraUpdate.newLatLng(newLocation));
    _getAddressFromLatLng(newLocation);
  }

  /// Get address from latitude and longitude
  Future<void> _getAddressFromLatLng(LatLng position) async {
    setState(() {
      _isFetchingAddress = true;
    });

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _address =
              "${place.street}, ${place.locality}, ${place.country} ${place.postalCode}";
        });
      }
    } catch (e) {
      print("Error getting address: $e");
    }

    setState(() {
      _isFetchingAddress = false;
    });
  }

  /// When the camera stops moving, update the location and fetch address
  void _onCameraIdle() {
    _getAddressFromLatLng(_currentLatLng);
  }

  /// Update the current location on camera move
  void _onCameraMove(CameraPosition position) {
    setState(() {
      _manualAddress = false;
      _currentLatLng = position.target;
      _address = "Fetching location..."; // Reset address while moving
    });
  }

  void _onConfirmLocation() {
    if (_manualAddress) {
      if (_formKey.currentState!.validate()) {
        _address =
            "${addressController.text}, ${cityController.text} ,${stateController.text}, ${pinController.text} ";
        Navigator.pop(context, _address);
      }
    } else {
      Navigator.pop(context, _address);
    }
    print("Confirmed Location: $_currentLatLng, Address: $_address");
  }

  @override
  void dispose() {
    addressController.dispose();
    stateController.dispose();
    cityController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                //  height: MediaQuery.sizeOf(context).height * 0.7,
                child: Stack(
                  children: [
                    // Google Map
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: _currentLatLng,
                          zoom: 15.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                        },
                        onCameraMove: _onCameraMove,
                        onCameraIdle:
                            _onCameraIdle, // Fetch address when camera stops moving
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                      ),
                    ),

                    // Custom App Bar
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(20), // Rounded bottom-left corner
                          bottomRight: Radius.circular(
                              20), // Rounded bottom-right corner
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.6),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Venue location",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(width: 40), // Balance alignment
                        ],
                      ),
                    ),

                    // Center pin icon
                    Center(
                      child: Image.asset('assets/icons/location_marker.png'),
                    ),

                    // Floating Action Button for recentering
                    Positioned(
                      bottom: 20,
                      right: 15,
                      child: FloatingActionButton(
                        onPressed: _getUserLocation,
                        shape: CircleBorder(),
                        backgroundColor: Colors.white,
                        child: Image.asset("assets/icons/gps.png", width: 25.0),
                      ),
                    ),
                    // Bottom panel for showing location details
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_manualAddress)
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InputFieldWidget(
                                label: "Address",
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Address field is required";
                                  }
                                  return null;
                                },
                                textEditingController: addressController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputFieldWidget(
                                label: "State",
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "State field is required";
                                  }
                                  return null;
                                },
                                textEditingController: stateController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputFieldWidget(
                                label: "Postal code",
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Postal code field is required";
                                  }
                                  return null;
                                },
                                textEditingController: pinController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputFieldWidget(
                                label: "City",
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "City field is required";
                                  }
                                  return null;
                                },
                                textEditingController: cityController,
                              )
                            ],
                          ),
                        ),
                      if (!_manualAddress)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current location",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),
                            _isFetchingAddress
                                ? Text("Fetching location...",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight
                                            .w500)) // Show loader when fetching address
                                : Text(
                                    _address,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ],
                        ),
                      SizedBox(height: 20),
                      MyButton(
                        onPressed: _onConfirmLocation,
                        text: "Confirm location",
                        width: double.infinity,
                      ),
                      SizedBox(height: 12),
                      if (!_manualAddress)
                        Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _manualAddress = true;
                              });
                            },
                            child: Text(
                              "Enter manually",
                              style: TextStyle(
                                  color: CustomTheme.appColorSecondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
