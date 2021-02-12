class User {
  String uid;
  String name;
  String surname;
  String email;

  User({this.uid, this.name, this.surname, this.email});

  String getUid() {
    return this.uid;
  }

  void setUid(String uid) {
    this.uid = uid;
  }

  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getSurname() {
    return this.surname;
  }

  void setSurname(String surname) {
    this.surname = surname;
  }

  String getEmail() {
    return this.email;
  }

  void setEmail(String email) {
    this.email = email;
  }
}
