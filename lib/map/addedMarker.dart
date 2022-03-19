import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clippy_flutter/triangle.dart';
import 'map.dart';

Marker addedMarker(cordinate, id, key, icon, index) {

  return Marker(
    position: cordinate,
    markerId: MarkerId(id.toString()),
    icon: icon[1],
    onTap: () {
      showModalBottomSheet<void>(
          context: key.currentContext,
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
                    Text("${index} 번"),
                    ElevatedButton(
                      child: Text("좋아요"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          });
    },
  );
}
