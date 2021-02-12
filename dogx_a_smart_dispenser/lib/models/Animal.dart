//modello relativo al singolo animale
//da decidere bene quali sono gli attributi da inserire

class Animal {
  String idCollar;
  String name;
  int dailyRation;
  int availableRation;
  String userId;
  
  Animal({this.idCollar, this.name, this.dailyRation, 
          this.availableRation, this.userId});

  String getIdCollar() {
    return this.idCollar;
  }

  void setIdCollar(String idCollar) {
    this.idCollar = idCollar;
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
}