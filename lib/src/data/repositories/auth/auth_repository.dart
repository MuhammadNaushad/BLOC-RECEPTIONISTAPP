import 'auth_remote_repository.dart';

class AuthRepository {
  static final AuthRepository _authRepository = AuthRepository._internal();

  late AuthRemoteRepository _authRemoteRepository;

  factory AuthRepository() {
    _authRepository._authRemoteRepository = AuthRemoteRepository();
    return _authRepository;
  }

  AuthRepository._internal();

  Future<Map<String, dynamic>> login(
      {required String email, required String password, String? fcmToken}) {
    final result =
        _authRemoteRepository.login(email: email, password: password);
    return result;
  }
}
