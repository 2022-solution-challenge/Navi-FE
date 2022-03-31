import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:like_button/like_button.dart';
import 'bookMark.dart';
import 'map.dart';

Marker addedMarker(cordinate, id, key, icon, index, myData) {

  return Marker(
    position: cordinate,
    markerId: MarkerId(id.toString()),
    icon: (icon[index]),
    onTap: () {
      showModalBottomSheet<void>(
          context: key.currentContext,
          barrierColor: Colors.white.withOpacity(0),
          builder: (BuildContext context) {
            return Container(height: 200, child: getBottomSheet(myData, icon[index]));
          });
    },
  );
}

class LikeBtn extends StatelessWidget {
  BookMark myLike;
  LikeBtn(this.myLike);

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();
    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    myLike.isCheckedLike = !myLike.isCheckedLike;
    myLike.likeNum =
        myLike.isCheckedLike ? myLike.likeNum + 1 : myLike.likeNum - 1;

    //데이터 쏴주기!!
    return !isLiked;
  }

  bool like = false;

  @override
  Widget build(BuildContext context) {
    like = myLike.isCheckedLike;
    return Container(
      height: 40,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LikeButton(
              size: 30,
              likeCountPadding: const EdgeInsets.all(10.0),
              likeCount: myLike.likeNum,
              isLiked: myLike.isCheckedLike,
              onTap: onLikeButtonTapped,
              likeBuilder: (like) {
                return Icon(
                  Icons.flag,
                  color: like ? Colors.red : Colors.grey,
                  size: 30,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget getBottomSheet(BookMark myData, BitmapDescriptor currentIcon) {
  String lat = myData.position.latitude.toString();
  String lng = myData.position.longitude.toString();

  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 32),
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(179, 255, 92, 92),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hytech City Public School",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text("Memorial Park",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("${double.parse(lat).toStringAsFixed(3)}, ${double.parse(lng).toStringAsFixed(3)}",
                            style: TextStyle(color: Colors.white, fontSize: 14))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LikeBtn(myData)
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton(
              backgroundColor: Color.fromARGB(179, 255, 92, 92),
              child: Icon(
                Icons.navigation,
              ),
              onPressed: () {}),
        ),
      )
    ],
  );
}
