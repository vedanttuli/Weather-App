import 'location.dart';
import 'networking.dart';
import 'package:weather_app/constants.dart';

class WeatherModel{

  String getWeatherIcon (int condition){
    if (condition<300){
      return 'thunderstorm' ;
    }else if (condition<400){
      return 'rain';
    }else if(condition<600){
      return 'rain';
    }else if(condition<700){
      return 'snow';
    }else if (condition == 800){
      return 'sunny';
    }else{
      return 'cloudy';
    }
  }



  Future<dynamic> getCityWeather(String cityName)async{

    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
        'https://api.openweathermap.org/data/2'
            '.5/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;

  }

  Future<dynamic> getLocationWeather()async{

    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
        'https://api.openweathermap.org/data/2'
            '.5/weather?lat=${location.latitude}&lon=${location
            .longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;

  }

}