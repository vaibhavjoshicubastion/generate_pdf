import 'package:flutter/material.dart';

class Model{
  final String title;
  final List<List<String>> specs;
  final int length;
  Model({required this.title, required this.specs, required this.length});
}

List<Model> models = <Model>[
  Model(
    length: 5,
    title: 'TIRE',
    specs: [['Front Wheel Right','mm'], ['Front Wheel Left','mm'],[ 'Rear Wheel Right','mm'], ['Rear Wheel Left' ,'mm'], ['Spare Wheel','mm']],
  ),
  Model(
    length: 4,
    title: 'Brake Pad',
    specs: [['Front Wheel Right','mm'], ['Front Wheel Left','mm'],[ 'Rear Wheel Right','mm'], ['Rear Wheel Left' ,'mm']],
  ),
  Model(
    length: 4,
    title: 'Brake Disc',
    specs: [['Front Wheel Right','mm'], ['Front Wheel Left','mm'],[ 'Rear Wheel Right','mm'], ['Rear Wheel Left' ,'mm'],],
  ),
];