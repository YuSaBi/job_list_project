class mailResponseModel {
  int mailID;
  int mailFromID;
  String? mailFromName;
  int mailToID;
  String? mailToName;
  String? title;
  String? message;
  bool isImportant;
  DateTime mailDateTime;
  bool secili = false;

  mailResponseModel(
    this.mailID,
    this.mailFromID,
    this.mailFromName,
    this.mailToID,
    this.mailToName,
    this.title,
    this.message,
    this.isImportant,
    this.mailDateTime,
  );

}