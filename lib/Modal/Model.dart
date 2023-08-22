import 'package:flutter/material.dart';

class Model {
  final String title;
  final List<SubModel> specs;
  final int itemLength;

  Model({required this.title, required this.specs, required this.itemLength});
}

class SubModel {
  final String specItemName;
  final String specItemValue;
  final String specItemUnit;
  bool isReplaceable;
  bool isGood;

  SubModel(
      {required this.specItemName,
      required this.specItemValue,
      required this.specItemUnit,
      required this.isReplaceable,
      required this.isGood});
}

List<Model> models = <Model>[
  Model(
    itemLength: 5,
    title: 'Tyre',
    specs: [
      SubModel(
          specItemName: "Front Wheel Right",
          specItemValue: "6.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Front Wheel Left",
          specItemValue: "5.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Rear Wheel Right",
          specItemValue: "4.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Rear Wheel Left",
          specItemValue: "3.5",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Spare Wheel",
          specItemValue: "0.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
    ],
  ),
  Model(
    itemLength: 4,
    title: 'Brake Pad',
    specs: [
      SubModel(
          specItemName: "Front Wheel Right",
          specItemValue: "6.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Front Wheel Left",
          specItemValue: "5.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Rear Wheel Right",
          specItemValue: "4.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Rear Wheel Left",
          specItemValue: "3.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
    ],
  ),
  Model(
    itemLength: 4,
    title: 'Brake Disc',
    specs: [
      SubModel(
          specItemName: "Front Wheel Right",
          specItemValue: "6.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Front Wheel Left",
          specItemValue: "5.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Rear Wheel Right",
          specItemValue: "4.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
      SubModel(
          specItemName: "Rear Wheel Left",
          specItemValue: "3.0",
          specItemUnit: "mm",
          isReplaceable: false,
          isGood: false),
    ],
  ),
];

class ServiceCheckPoint {
  bool? isSelected;
  String? checkPointName;

  ServiceCheckPoint({this.isSelected, this.checkPointName});

}

class HealthCardData {
  List<Model> healthMeter;
  BatteryCondition batteryCondition;
  String voltage;
  GenuineData genuineData;
  bool isNoFaults;
  String remarks;
  String personalizedAdvice;
  NextMaintenanceInterval nextMaintenanceInterval;
  List<ServiceCheckPoint> serviceCheckPointList;

  HealthCardData(
      {required this.healthMeter,
      required this.batteryCondition,
      required this.voltage,
      required this.genuineData,
      required this.isNoFaults,
      required this.remarks,
      required this.personalizedAdvice,
      required this.nextMaintenanceInterval,
      required this.serviceCheckPointList});
}

class BatteryCondition{
  bool changeBattery;
  bool hasGoodCondition;

  BatteryCondition({required this.changeBattery, required this.hasGoodCondition});
}

class GenuineData{
  bool isGenuine;
  bool isNonGenuine;

  GenuineData({required this.isGenuine, required this.isNonGenuine});
}

class NextMaintenanceInterval {
  String futureKilometers;
  String nextDueDate;

  NextMaintenanceInterval(
      {required this.futureKilometers, required this.nextDueDate});
}

