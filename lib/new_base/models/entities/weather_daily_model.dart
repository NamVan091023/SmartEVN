class WeatherDataDaily {
  List<Daily> daily;
  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) => WeatherDataDaily(
    daily: (json['daily'] as List<dynamic>)
        .map((e) => Daily.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

class Daily {
  int? dt;
  Temp? temp;
  double? windSpeed;
  double? winDeg;
  double? pop;
  List<Weather>? weather;
  Daily({
    this.dt,
    this.temp,
    this.weather,
    this.windSpeed,
    this.winDeg,
    this.pop
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json['dt'] as int?,
    temp: json['temp'] == null ? null : Temp.fromJson(json['temp'] as Map<String, dynamic>),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    winDeg: (json['wind_deg'] as num?)?.toDouble(),
    pop: (json['pop'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'temp': temp?.toJson(),
    'wind_speed': windSpeed,
    'wind_deg': winDeg,
    'pop': pop,
    'weather': weather?.map((e) => e.toJson()).toList(),
  };
}

class Temp {
  double? day;
  int? min;
  int? max;

  Temp({this.day, this.min, this.max});

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: (json['day'] as num?)?.toDouble(),
    min: (json['min'] as num?)?.round(),
    max: (json['max'] as num?)?.round(),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'min': min,
    'max': max,
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
