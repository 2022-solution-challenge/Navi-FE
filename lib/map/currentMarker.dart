import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';

import 'dart:async';
import 'dart:math';

Marker currentMarker(cordinate, id, context, _customInfoWindowController, mymarkers) {

  return Marker(
        position: cordinate,
        markerId: MarkerId(id.toString()),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Column(
              children: [
                Expanded(
                    child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add Bookmark",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Colors.white,
                                    ),
                          )
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        barrierColor: Colors.white.withOpacity(0),
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Modal BottomSheet'),
                                  ElevatedButton(
                                    child: const Text('북마크에 추가하기'),
                                    onPressed: () {
                                      mymarkers.markerlist.add((Marker(
                                          position: cordinate,
                                          markerId: MarkerId(id.toString()))));

                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )),
                Triangle.isosceles(
                  edge: Edge.BOTTOM,
                  child: Container(
                    color: Colors.blue,
                    width: 20.0,
                    height: 10.0,
                  ),
                ),
              ],
            ),
            cordinate,
          );
        },
      );
}
