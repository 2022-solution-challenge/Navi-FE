import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clippy_flutter/triangle.dart';
import 'addedMarker.dart';
import 'bookMark.dart';

class PrimitiveWrapper {
  int index;
  PrimitiveWrapper(this.index);
}

Marker currentMarker(
    cordinate, id, context, _customInfoWindowController, mymarkers, key, icon) {
  BitmapDescriptor currentIcon = icon[0];

  final selectedIndex = new PrimitiveWrapper(0);

  BookMark markerData = BookMark(cordinate, 0, 0, id, false);

  // final markerImage = new PrimitiveWrapper([currentIcon]);

  SelectButton selectbtn = SelectButton();

  return Marker(
    position: cordinate,
    markerId: MarkerId(id.toString()),
    icon: currentIcon,
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
                        style: Theme.of(context).textTheme.headline6?.copyWith(
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
                    barrierColor: Colors.black.withOpacity(0.3),
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('현재 선택한 마커'),
                              selectbtn,
                              ElevatedButton(
                                child: const Text('북마크에 추가하기'),
                                onPressed: () {
                                  //api 쏴주는 부분
                                  mymarkers.markerlist.add(addedMarker(
                                      cordinate,
                                      id,
                                      key,
                                      icon,
                                      selectbtn.index,
                                      markerData));
                                  Navigator.pop(context);
                                },
                              ),
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

// class BottomModalItems extends StatelessWidget {
//   const BottomModalItems({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(

//  );
//   }
// }

class MyButtonModal {
  final String buttonText;
  // New field to uniquely identify a button
  final int index;

  MyButtonModal({this.buttonText = 'default', this.index = -1});
}

class SelectButton extends StatefulWidget {
  SelectButton({Key? key}) : super(key: key);

  int _index = 0;
  int get index => _index;

  @override
  _SelectButtonState createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  List<MyButtonModal> _a = List.generate(5,
      (index) => MyButtonModal(buttonText: "Btn ${index + 1}", index: index));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: GridView.count(
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        crossAxisCount: 5,
        physics: new NeverScrollableScrollPhysics(),
        children: _a.map((MyButtonModal f) {
          return InkWell(
            child: Container(
                height: 10,
                decoration: BoxDecoration(
                    // Check if f.index == index
                    color:
                        f.index == widget._index ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xffaaaaaa))),
                child: Center(
                  child: Text(f.buttonText),
                )),
            onTap: () {
              // When button is tapped update index to the index of the button
              setState(() {
                widget._index = f.index;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
