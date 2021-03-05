class Dispenser {
  String id;
  String userId;
  int qtnRation; // se questa variabile è !=0 allora bisogna erogare.
  String collarId;


  Dispenser(
      {this.id, this.userId, this.qtnRation, this.collarId});

  String getIdDispenser() {
    return this.id;
  }

  void setIdDispenser(String id) {
    this.id = id;
  }

  String getUserId() {
    return this.userId;
  }

  void setUserId(String name) {
    this.userId = userId;
  }

  int getQtnRation() {
    return this.qtnRation;
  }

  void setqtnRation(int qtnRation) {
    this.qtnRation = qtnRation;
  }

  String getCollarId() {
    return this.collarId;
  }

  void setCollarId(String collarId) {
    this.collarId = collarId;
  }
}
