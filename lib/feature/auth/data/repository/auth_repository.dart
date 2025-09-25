import 'package:dart_either/dart_either.dart';
import 'package:konta_app/common/utils/failure.dart';
import 'package:konta_app/feature/auth/data/model/user_profile.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserProfile>> get currentUser;

  Future<Either<Failure, UserProfile>> signInWithPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserProfile>> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, void>> signOut();
}
