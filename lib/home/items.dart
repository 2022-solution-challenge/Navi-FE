import 'package:flutter/material.dart';

class Item {

	String name;
	String description;
	MaterialColor color;
	IconData icon;
	Item(this.name, this.description, this.color, this.icon);
}

List<Item> items = [
	Item('추가', "Something cool", Colors.amber, Icons.add),
	Item('집', "Hey, why not?", Colors.cyan, Icons.home),
	Item('학교', "This might be OK", Colors.indigo, Icons.school),
	Item('D', "Totally awesome", Colors.green, Icons.crop),
	Item('E', "Rockin out", Colors.pink, Icons.album),
	Item('F', "Take a look", Colors.blue, Icons.adb)
];