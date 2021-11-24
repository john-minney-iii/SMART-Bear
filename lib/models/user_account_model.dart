class UserAccount {
  String role;
  String email;
  String id;

  UserAccount({required this.role, required this.email, required this.id});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
        role: json['role'], email: json['email'], id: json['id']);
  }
}
