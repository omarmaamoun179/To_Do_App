class USerModel {
  static const String userCollectionName = 'Users';
  String id;
  String name;
  int age;
  String email;
  USerModel({
    this.id = "",
    required this.name,
    required this.age,
    required this.email,
  });
  USerModel.fromFireStore(Map<String, dynamic> json)
      : this(
          age: json['age'],
          name: json['name'],
          email: json['email'],
        );

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'email': email,
    };
  }
}
