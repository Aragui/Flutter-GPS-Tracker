import 'package:rxdart/rxdart.dart';
import 'package:gps_tracker/db/user_location.dart';
import 'package:location/location.dart';

class LocationBloc {
  final _loctnController = BehaviorSubject<LocationData>();

  Stream<LocationData> get locationStream => _loctnController.stream;

  final _location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  final usrLoc = UserLocation();

  void initLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _location.enableBackgroundMode(enable: true);
    _location.onLocationChanged.listen((event) async {
      // print(event);
      try {
        final res = await usrLoc.setLocation(event);
        if (res) {
          _loctnController.sink.add(event);
        }
      } catch (e) {
        print(e);
        _loctnController.sink.addError(e);
      }
    });
  }

  void dispose() {
    _loctnController.close();
  }
}

// keytool -list -v -alias androiddebugkey -keystore C:\Users\guill\.android\debug.keystore
