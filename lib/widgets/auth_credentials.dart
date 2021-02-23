// 1
abstract class AuthCredentials {
  final String username;
  final String password;

  AuthCredentials({this.username, this.password});
}

// 2
class LoginCredentials extends AuthCredentials {
  LoginCredentials({String username, String password})
      : super(username: username, password: password);
}

// 3
class SignUpCredentials extends AuthCredentials {
  final String email;
  final String address;
  final String phone;
 
  SignUpCredentials({String username, String password, this.email, this.address,this.phone})
      : super(username: username, password: password);

}