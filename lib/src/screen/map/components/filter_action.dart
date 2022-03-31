import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/helper.dart';

import '../map_controller.dart';

class FilterAction extends StatelessWidget {
  const FilterAction({
    Key? key,
    required MapController controller,
  })  : _controller = controller,
        super(key: key);

  final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 40,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 10,
            right: 5,
            left: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: IconButton(
                focusColor: Colors.green,
                icon: Icon(
                  Icons.gps_fixed_rounded,
                ),
                onPressed: () {
                  _controller.getPos();
                },
              ),
              decoration: new BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(8.0))),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                  child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    // color: getQualityColor(index + 1),
                    child: Center(
                        child: Text(
                      getQualityText(index + 1),
                      style: TextStyle(color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                      borderRadius: index == 5
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            )
                          : index == 0
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                )
                              : null,
                      color: getQualityColor(index + 1),
                    ),
                  );
                },
                itemCount: 6,
              )),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.list_rounded,
                ),
                onPressed: () {},
              ),
              decoration: new BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(8.0))),
            ),
          ],
        ),
      ),
    );
  }
}
