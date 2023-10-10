import 'package:laporbos/service/authService.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<void> login(String username, String password) async {
    return await authService.login(username, password);
  }
}
