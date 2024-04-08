
class WeatherDataCurrent {
  final Current current;

  WeatherDataCurrent({required this.current});

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Current.fromJson(json['current']));
}

class Current {
  int? temp;
  int? humidity;
  double? windSpeed;
  double? winDeg;
  List<Weather>? weather;

  Current({
    this.temp,
    this.humidity,
    this.winDeg,
    this.windSpeed,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    temp: (json['temp'] as num?)?.round(),
    humidity: json['humidity'] as int?,
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    winDeg: (json['wind_deg'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'humidity': humidity,
    'wind_speed': windSpeed,
    'wind_deg' : winDeg,
    'weather': weather?.map((e) => e.toJson()).toList(),
  };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json['id'] as int?,
    main: json['main'] as String?,
    description: json['description'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}
