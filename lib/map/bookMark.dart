// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookMark {
  LatLng position;
  int index;
  int likeNum;
  int id;
  bool isCheckedLike;

  BookMark(this.position, this.index, this.likeNum, this.id, this.isCheckedLike);
}

List<BookMark> items = [
  BookMark(LatLng(37.87189568090562, -122.25841638772661), 3, 50, 2, false),
];