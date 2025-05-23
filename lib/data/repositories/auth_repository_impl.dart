import 'package:fake_store/data/datasources/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:fake_store/domain/repositories/auth_repository.dart';
import 'package:fake_store/domain/entities/user.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User?> login(String username, String password) async {
    final userModel = await remoteDataSource.login(username, password);
    return userModel?.toEntity();
  }
}
