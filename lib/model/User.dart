class User {
  static const String COLLECTION_NAME = "users";
  String id;
  String userName;
  String email;
  User({required this.id, required this.email, required this.userName});
  User.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          email: json['email']! as String,
          userName: json['userName']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
    };
  }
}
