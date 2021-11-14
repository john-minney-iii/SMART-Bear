class UserAccount {
  bool admin;
  String email;

  UserAccount({
    required this.admin,
    required this.email
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      admin: json['admin'],
      email: json['email']
    );
  }

}