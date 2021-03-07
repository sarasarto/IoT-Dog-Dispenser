class Animal {
  String collarId; //si usa questo per definire il doc id di firebase
  String name;
  int dailyRation;
  int availableRation;
  String userId;
  int foodCounter;

  Animal(
      {this.collarId,
      this.name,
      this.dailyRation,
      this.availableRation,
      this.userId,
      this.foodCounter});

  String getIdCollar() {
    return this.collarId;
  }

  void setIdCollar(String collarId) {
    this.collarId = collarId;
  }

  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getUserId() {
    return this.userId;
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  int getDailyQuantity() {
    return this.dailyRation;
  }

  void setDailyQuantity(int dailyRation) {
    this.dailyRation = dailyRation;
  }

  int getAvailableQuantity() {
    return this.availableRation;
  }

  void setAvailableQuantity(int availableRation) {
    this.availableRation = availableRation;
  }

  int getFoodCounter() {
    return this.foodCounter;
  }

  void setFoodCounter(int foodCounter) {
    this.foodCounter = foodCounter;
  }
}
