import 'package:geolocator/geolocator.dart';

class Location{

  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }else{
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          latitude = position.latitude;
          longitude = position.longitude;

        } catch (e){
          print(e);
        }
      }
    }else {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        latitude = position.latitude;
        longitude = position.longitude;

      } catch(e){
        print(e);
      }
    }
  }

}