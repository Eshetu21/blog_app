import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        left(Failures("No internet connection"));
      }
      final user = await remoteDataSource.getcurrentUserData();
      if (user == null) {
        return left(Failures("User not found"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      if (!await connectionChecker.isConnected) {
        left(Failures("No internet connection"));
      }
      final user = await remoteDataSource.loginWithEmailPassword(
          email: email, password: password);
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failures(e.message));
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> signupWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      if (!await connectionChecker.isConnected) {
        left(Failures("No internet connection"));
      }
      final user = await remoteDataSource.signupWithEmailPassword(
          name: name, email: email, password: password);
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failures(e.message));
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
