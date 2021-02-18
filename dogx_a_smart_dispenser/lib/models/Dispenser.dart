//modello relativo al dispenser
//rimane da decidere bene gli attributi da inserire.

import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';

class Dispenser {
  String id;
  String userId;
  bool daErogare;
  int qtnRation;
  List<Animal> animals;

  Dispenser(
      {this.id, this.userId, this.daErogare, this.qtnRation, this.animals});

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

  bool getDaErogare() {
    return this.daErogare;
  }

  void setDaErogare(bool daErogare) {
    this.daErogare = daErogare;
  }

  int getQtnRation() {
    return this.qtnRation;
  }

  void setqtnRation(int qtnRation) {
    this.qtnRation = qtnRation;
  }

  List<Animal> getAnimal() {
    return this.animals;
  }

  void setAnimal(List<Animal> animals) {
    this.animals = animals;
  }
}
