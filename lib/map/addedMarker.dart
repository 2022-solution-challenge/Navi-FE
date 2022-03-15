import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clippy_flutter/triangle.dart';
import 'map.dart';

Marker addedMarker(cordinate, id, key) {

  return Marker(
    position: cordinate,
    markerId: MarkerId(id.toString()),
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
                    const Text('Modal BottomSheet'),
                    ElevatedButton(
                      child: const Text('좋아요'),
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
