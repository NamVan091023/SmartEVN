import 'package:flutter/material.dart';

enum MapFilterType { layer, marker }

class MapFilterModel {
  String name;
  String value;
  Map colors;
  MapFilterType type;
  MapFilterModel(this.name, this.value, this.colors, this.type);
}

class MapLayerFilterValue {
  static MapFilterModel temperature = MapFilterModel(
    "Nhiệt độ",
    "TA2",
    {
      -65: Color(0x82169200),
      -55: Color(0x82169200),
      -45: Color(0x82169200),
      -40: Color(0x82169200),
      -30: Color(0x8257DB00),
      -20: Color(0x208CEC00),
      -10: Color(0x20C4E800),
      0: Color(0x23DDDD00),
      10: Color(0xC2FF2800),
      20: Color(0xFFF02800),
      25: Color(0xFFC22800),
      30: Color(0xFC801400)
    },
    MapFilterType.layer,
  );

  static MapFilterModel wind = MapFilterModel(
    "Tốc độ gió",
    "WND",
    {
      1: Color(0xFFFFFF00),
      5: Color(0xEECECC66),
      15: Color(0xB364BCB3),
      25: Color(0x3F213BCC),
      50: Color(0x744CACE6),
      100: Color(0x4600AFFF),
      200: Color(0x0D1126FF),
    },
    MapFilterType.layer,
  );

  static MapFilterModel accumulated = MapFilterModel(
    "Lượng mưa tích lũy",
    "PA0",
    {
      0: Color(0x00000000),
      0.1: Color(0xC8969600),
      0.2: Color(0x9696AA00),
      0.5: Color(0x7878BE19),
      1: Color(0x6E6ECD33),
      10: Color(0x5050E1B2),
      140: Color(0x1414FFE5),
    },
    MapFilterType.layer,
  );

  static MapFilterModel humidity = MapFilterModel(
    "Độ ẩm",
    "HRD0",
    {
      0: Color(0x00000000),
      0.1: Color(0xC8969600),
      0.2: Color(0x9696AA00),
      0.5: Color(0x7878BE19),
      1: Color(0x6E6ECD33),
      10: Color(0x5050E1B2),
      140: Color(0x1414FFE5),
    },
    MapFilterType.layer,
  );
}
