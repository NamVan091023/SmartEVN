import 'package:flutter/material.dart';
import 'package:pollution_environment/src/components/aqi_card.dart';
import 'package:share_plus/share_plus.dart';

import '../map_controller.dart';

class ViewAQISelected extends StatelessWidget {
  const ViewAQISelected({
    Key? key,
    required MapController controller,
  })  : _controller = controller,
        super(key: key);

  final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _controller.offset,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Card(
          // width: 200,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 10,
              right: 5,
              left: 5),
          child: ListView(
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(
                  _controller.aqiMarkerSelected.value?.name ?? "Chỉ số AQI",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                trailing: IconButton(
                    onPressed: () {
                      Share.share(
                          "Chỉ số không khí tại ${_controller.aqiMarkerSelected.value?.name ?? ""} là ${_controller.aqiMarkerSelected.value?.aqi ?? 0}. Xem chi tiết tại ứng dụng Smart Environment");
                    },
                    icon: Icon(Icons.share_rounded)),
              ),
              _controller.aqiMarkerSelected.value != null
                  ? AQICard(
                      aqiModel: _controller.aqiMarkerSelected.value!,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
