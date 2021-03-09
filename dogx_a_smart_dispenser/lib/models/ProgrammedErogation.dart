class ProgrammedErogation {
  String dispenserId;
  String collarId;
  int qtnRation;
  String date;
  String time;

  ProgrammedErogation({this.dispenserId, this.collarId, this.qtnRation});

  String getDispenserId() {
    return this.dispenserId;
  }

  void setDispenserId(String dispenserId) {
    this.dispenserId = dispenserId;
  }

  String getCollarid() {
    return this.collarId;
  }

  void setCollarId(String collarId) {
    this.collarId = collarId;
  }

  int getQtnRation() {
    return this.qtnRation;
  }

  void setQtnRation(int qtnRation) {
    this.qtnRation = qtnRation;
  }

  String getDate() {
    return this.date;
  }

  void setDate(String date) {
    this.date = date;
  }

  String getTime() {
    return this.time;
  }

  void setTime(String time) {
    this.time = time;
  }
}
