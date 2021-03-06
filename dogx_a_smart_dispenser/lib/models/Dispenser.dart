class Dispenser {
  String id;
  String userId;
  int qtnRation; // se questa variabile è !=0 allora bisogna erogare.
  String collarId;
  bool food_state;

  Dispenser({this.id, this.userId, this.qtnRation, this.collarId, this.food_state});

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

  bool getFoodStateDispenser() {
    return this.food_state;
  }

  void setFoodStateDispenser(bool food_state) {
    this.food_state = food_state;
  }
}
