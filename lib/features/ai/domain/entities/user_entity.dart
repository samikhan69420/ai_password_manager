class UserEntity {
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? description;

  UserEntity(
      {this.firstName, this.lastName, this.dateOfBirth, this.description, mn});

  UserEntity.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dateOfBirth'] = dateOfBirth;
    data['description'] = description;
    return data;
  }
}
