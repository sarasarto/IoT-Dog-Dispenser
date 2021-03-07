class Dispenser {
  String id;
  String userId;
  int qtnRation; // se questa variabile è !=0 allora bisogna erogare.
  String collarId;
  //bool foodState;
  int foodState;

  Dispenser(
      {this.id, this.userId, this.qtnRation, this.collarId, this.foodState});

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

  /*bool getFoodState() {
    return this.foodState;
  }

  void setFoodState(bool foodState) {
    this.foodState = foodState;
  }*/

  int getFoodState() {
    return this.foodState;
  }

  void setFoodState(int foodState) {
    this.foodState = foodState;
  }
}
