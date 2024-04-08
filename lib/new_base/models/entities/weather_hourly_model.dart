
class WeatherDataHourly{
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) => WeatherDataHourly(
    hourly: (json['hourly'] as List<dynamic>)
        .map((e) => Hourly.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}


class Hourly {
  int? dt;
  int? temp;
  double? windSpeed;
  double? windDeg;
  List<Weather>? weather;
  Hourly({
    this.dt,
    this.temp,
    this.windSpeed,
    this.windDeg,
    this.weather,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    dt: json['dt'] as int?,
    temp: (json['temp'] as num?)?.toInt(),
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    windDeg: (json['win_deg'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'temp': temp,
    'wind_speed': windSpeed,
    'win_deg': windDeg,
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

