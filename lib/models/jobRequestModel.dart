class jobRequestModel {
  int Id;
  String? baslik;
  String? detay;
  int harcananSure;
  int musteri;
  int durum;
  int oncelik;
  bool secili = false;

  jobRequestModel(
    this.Id,
    this.baslik,
    this.detay,
    this.durum,
    this.harcananSure,
    this.musteri,
    this.oncelik,
  );

}