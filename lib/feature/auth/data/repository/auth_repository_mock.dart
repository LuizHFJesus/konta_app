import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/auth/data/model/user_profile.dart';
import 'package:konta_app/feature/auth/data/repository/auth_repository.dart';

class AuthRepositoryMock implements AuthRepository {
  UserProfile? _currentUser;
  final List<UserProfile> _users = [
    UserProfile(id: '123', name: 'Usuário Teste', email: 'teste@konta.app'),
  ];

  @override
  Future<Either<Failure, UserProfile>> get currentUser async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (_currentUser != null) {
      return Right(_currentUser!);
    } else {
      return Left(Failure('Nenhum usuário logado.'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> signInWithPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (_users.any((e) => e.email == email)) {
      final user = _users.firstWhere((e) => e.email == email);
      _currentUser = user;
      return Right(user);
    } else {
      return Left(Failure('E-mail ou senha inválidos.'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (_users.any((e) => e.email == email)) {
      return Left(Failure('E-mail já cadastrado'));
    } else {
      final newUser = UserProfile(
          id: 'mock_uid_${DateTime.now().millisecondsSinceEpoch}',
          name: name,
          email: email
      );

      _users.add(newUser);
      _currentUser = newUser;

      return Right(_currentUser!);
    }
  }

  Future<Either<Failure, void>> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;
    return const Right(null);
  }
}
