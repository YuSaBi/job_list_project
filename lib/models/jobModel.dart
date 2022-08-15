//import 'package:flutter/rendering.dart';

class jobModel {
  int Id;
  String? baslik;
  String? detay;
  DateTime gun;
  int harcananSure;
  String? musteri;
  String? durum;
  String? oncelik;
  bool secili = false;

  jobModel(
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