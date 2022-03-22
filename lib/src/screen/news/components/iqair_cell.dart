import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pollution_environment/src/model/area_forest_model.dart';

class IQAirCell extends StatelessWidget {
  IQAirCell({Key? key, required this.areaForestModel, required this.onTap})
      : super(key: key);

  late final Function() onTap;
  late final AreaForestModel areaForestModel;
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          // height: 120,
          padding: const EdgeInsets.all(5),
          child: IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                  flex: 3,
                  child: Card(
                    color: _getColorRank(),
                    child: Center(
                      child: Text(
                        areaForestModel.rank ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ),
                  )),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 14,
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        areaForestModel.country ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text.rich(TextSpan(text: "Diện tích rừng: ", children: [
                        TextSpan(
                            text: areaForestModel.forestAreaHectares ?? "",
                            style: TextStyle(color: Colors.cyan)),
                        TextSpan(text: " hecta")
                      ])),
                      Text.rich(TextSpan(text: "Dân số: ", children: [
                        TextSpan(
                            text: areaForestModel.population2017 ?? "",
                            style: TextStyle(color: Colors.cyan)),
                        TextSpan(text: " người")
                      ])),
                      Text.rich(
                        TextSpan(text: "Diện tích/Người: ", children: [
                          TextSpan(
                              text: areaForestModel.sqareMetersPerCapita ?? "",
                              style: TextStyle(color: Colors.cyan)),
                          TextSpan(text: " m\u00B2")
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  Color _getColorRank() {
    if (areaForestModel.rank != null) {
      int rank = int.parse(areaForestModel.rank!);

      if (rank <= 10)
        return Colors.green;
      else if (rank <= 20)
        return Colors.cyan;
      else if (rank <= 50)
        return Colors.yellow;
      else if (rank <= 100)
        return Colors.orange;
      else
        return Colors.red;
    } else {
      return Colors.red;
    }
  }
}
