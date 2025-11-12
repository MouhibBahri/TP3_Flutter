class User {
  String email;
  String fullName;

  User() : email = '', fullName = '';
  User.withEmailAndName({required this.email, required this.fullName});
}
