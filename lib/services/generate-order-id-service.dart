import 'dart:math';

String generateOrderId(){
  DateTime now = DateTime.now();

  int ranndomNumbers = Random().nextInt(99999);
  String id = '${now.microsecondsSinceEpoch}_$ranndomNumbers';
  return id;
}