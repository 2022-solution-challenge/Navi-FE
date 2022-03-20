import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:like_button/like_button.dart';
import 'bookMark.dart';
import 'map.dart';

Marker addedMarker(cordinate, id, key, icon, index, myData) {
  return Marker(
    position: cordinate,
    markerId: MarkerId(id.toString()),
    icon: (icon[1]),
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
                    Text("${myData.id} 아이디 입니다"),
                    LikeBtn(myData),
                  ],
                ),
              ),
            );
          });
    },
  );
}

class LikeBtn extends StatelessWidget {
  // This widget is the root of your application.

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

    //데이터 쏴주기
    return !isLiked;
  }

  bool like = false;

  @override
  Widget build(BuildContext context) {
    like = myLike.isCheckedLike;
    return Container(
      height: 60,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LikeButton(
              size: 50,
              likeCountPadding: const EdgeInsets.all(10.0),
              likeCount: myLike.likeNum,
              onTap: onLikeButtonTapped,
              likeBuilder: (bool islike) {
                return Icon(
                  Icons.flag,
                  color: like ? Colors.red : Colors.grey,
                  size: 50,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
