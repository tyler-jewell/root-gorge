import 'package:flutter/material.dart';
import 'package:root_gorge/repositories/fields/models/herbicide.dart';

List<Herbicide> getHerbicides() {
  return [
    Herbicide('Dicamba', Colors.blue),
    Herbicide('Enlist', Colors.orange),
    Herbicide('Roundup', Colors.green),
    Herbicide('Non-GMO', Colors.yellow),
    Herbicide('Organic', Colors.red),
  ];
}
