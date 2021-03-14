class Dispenser {
  String id;
  String userId;
  int qtnRation; // se questa variabile è !=0 allora bisogna erogare.
  String
      collarId; // variabile che di default è null, e ci dice per quale animale erogare
  bool foodState;
  int totale;
  int cibo_rimasto;

  Dispenser(
      {this.id, this.userId, this.qtnRation, this.collarId, this.foodState, this.totale, this.cibo_rimasto});

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

  bool getFoodState() {
    return this.foodState;
  }

  void setFoodState(bool foodState) {
    this.foodState = foodState;
  }

  int getTotale() {
    return this.totale;
  }

  void setTotale(int totale) {
    this.totale = totale;
  }

    int getCiboRimasto() {
    return this.cibo_rimasto;
  }

  void setCiboRimasto(int cibo_rimasto) {
    this.cibo_rimasto = cibo_rimasto;
  }
}
