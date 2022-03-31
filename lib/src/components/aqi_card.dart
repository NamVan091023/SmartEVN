import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/aqi_map_model.dart';

class AQICard extends StatelessWidget {
  AQICard({Key? key, required this.aqiModel}) : super(key: key);

  final Markers aqiModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: 80,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    getAssetAQI(getAQIRank((aqiModel.aqi ?? 0).toDouble())),
                    color: Colors.black,
                  ),
                ),
                color:
                    getQualityColor(getAQIRank((aqiModel.aqi ?? 0).toDouble())),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                      0.9,
                    ],
                    colors: [
                      getQualityColor(
                              getAQIRank((aqiModel.aqi ?? 0).toDouble()))
                          .withAlpha(220),
                      getQualityColor(
                              getAQIRank((aqiModel.aqi ?? 0).toDouble()))
                          .withAlpha(170),
                      getQualityColor(
                              getAQIRank((aqiModel.aqi ?? 0).toDouble()))
                          .withAlpha(250),
                      getQualityColor(
                              getAQIRank((aqiModel.aqi ?? 0).toDouble()))
                          .withAlpha(100),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Center(
                        child: ListTile(
                          title: Text(
                            (aqiModel.aqi ?? 0).toStringAsFixed(1),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          subtitle: Text(
                            "AQI Mỹ",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          getQualityText(
                              getAQIRank((aqiModel.aqi ?? 0).toDouble())),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
    );
  }
}
