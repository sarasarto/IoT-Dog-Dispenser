//modello relativo al singolo animale
//da decidere bene quali sono gli attributi da inserire

import 'User.dart';

class Animal {
  String idCollar;
  String name;
  int dailyRation;
  int availableRation;
  User user;
  
  Animal({this.idCollar, this.name, this.dailyRation, 
          this.availableRation, this.user});

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

  User getUser() {
    return this.user;
  }

  void setUser(User user) {
    this.user = user;
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