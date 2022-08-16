//import 'package:flutter/rendering.dart';

class jobResponseModel {
  int Id;
  String? baslik;
  String? detay;
  DateTime gun;
  int harcananSure;
  String? musteri;
  String? durum;
  String? oncelik;
  bool secili = false;

  jobResponseModel(
    this.Id,
    this.baslik,
    this.detay,
    this.durum,
    this.gun,
    this.harcananSure,
    this.musteri,
    this.oncelik,
  );

}