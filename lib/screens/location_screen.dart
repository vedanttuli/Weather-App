import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  late int temperature;
  late int minTemperature;
  late int maxTemperature;
  late int feelsLikeTemperature;
  late int condition;
  late String cityName;
  late String countryName;
  late String topText;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        condition = 0;
        cityName = 'Error';
      }

      double temp = weatherData['main']['temp'];
      double feelsLikeTemp = weatherData['main']['feels_like'];
      double minTemp = weatherData['main']['temp_min'];
      double maxTemp = weatherData['main']['temp_max'];
      temperature = temp.toInt();
      minTemperature = minTemp.toInt();
      maxTemperature = maxTemp.toInt();
      feelsLikeTemperature = feelsLikeTemp.toInt();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      countryName = weatherData['sys']['country'];
      topText = weatherData['weather'][0]['description'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff353358),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      ),
                      Text('$topText', style: TextStyle(fontSize:35.0)),
                      GestureDetector(
                        onTap: () async {
                          var typedName = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          if (typedName != null) {
                            var weatherData =
                                await weather.getCityWeather(typedName);
                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.search,
                          size: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  color: Color(0xff353358),
                  child: FittedBox(
                    child: Image(
                        image: AssetImage(
                            'images/${weather.getWeatherIcon(condition)}-removebg-preview.png')),
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '$cityName, $countryName',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      '$temperatureᵒ',
                                      style: TextStyle(
                                        fontSize: 100.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 0, 16.0, 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Feels like $feelsLikeTemperatureᵒ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'High: $maxTemperatureᵒ',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Text(
                            'Low: $minTemperatureᵒ',
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

/*
Scaffold(
backgroundColor: Color(0xff35375A),
body: SafeArea(
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
GestureDetector(
onTap: () async {
var weatherData = await weather.getLocationWeather();
updateUI(weatherData);
},
child: Icon(
Icons.near_me,
size: 50.0,
),
),
GestureDetector(
onTap: () async{
var typedName = await Navigator.push(context,
MaterialPageRoute(builder: (context) {
return CityScreen();
}));
if (typedName != null){
var weatherData = await weather.getCityWeather(typedName);
updateUI(weatherData);
}
},
child: Icon(
Icons.location_city,
size: 50.0,
),
)
],
),
Padding(
padding: EdgeInsets.only(left: 15.0),
child: Row(
children: [
Expanded(
flex: 3,
child: Text(
'$temperatureᵒ',
style: TextStyle(
fontSize: 150.0,
fontWeight: FontWeight.bold,
),
),
),
Expanded(
flex: 1,
child: SizedBox(),
),
Expanded(
flex: 1,
child: Text(
'${weather.getWeatherIcon(condition)}',
textAlign: TextAlign.right,
style: TextStyle(
fontSize: 120.0,
fontWeight: FontWeight.bold,
),
),
),
],
),
),
Padding(
padding: EdgeInsets.only(left: 15.0),
child: Text(
'${weather.getMessage(temperature)} in $cityName!',
style: TextStyle(
fontSize: 60.0,
fontWeight: FontWeight.bold,
),
textAlign: TextAlign.right,
),
)
],
),
));*/
