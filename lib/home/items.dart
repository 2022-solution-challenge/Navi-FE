import 'package:flutter/material.dart';

class Item {

	String name;
	String description;
	MaterialColor color;
	IconData icon; 
	Item(this.name, this.description, this.color, this.icon);
}

List<Item> items = [
	Item('Add', "Add Data", Colors.amber, Icons.add),
	Item('Home', "lets go to Home", Colors.cyan, Icons.home),
	Item('School', "Lets go to School", Colors.indigo, Icons.school),
	Item('Playground', "Lets go to Playground", Colors.green, Icons.child_friendly),
];