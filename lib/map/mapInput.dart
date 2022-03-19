import 'package:flutter/material.dart';

class MapInput extends StatelessWidget {
  const MapInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      children: <Widget>[
        TogoInput(),

      ],
    )
  }
}

class TogoInput extends StatefulWidget {
  const TogoInput({Key? key}) : super(key: key);

  @override
  State<TogoInput> createState() => TogoInputState();
}

class TogoInputState extends State<TogoInput>{

  const

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Where to go?',
      ),
    )
  }
}
