import 'package:notes/services/auth/auth_provider.dart';
import 'package:notes/services/auth/auth_user.dart';

class AuthService implements AuthProvider{
  final AuthProvider provider;

  const AuthService(this.provider);
  
  @override
  Future<AuthUser> createuser({required String email, required String password}) {
    return provider.createuser(email: email, password: password);
  }
  
  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;
  
  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    return provider.logIn(email: email, password: password);
  }
  
  @override
  Future<void> logOut() => provider.logOut();
  
  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
  


}