import 'dart:developer';
import 'dart:io';

import 'package:fake_store/data/datasources/local/shared_preferences_manager.dart';
import 'package:fake_store/injection.dart';
import 'package:injectable/injectable.dart';
import '../../models/user_model.dart';
import '../../../core/network/dio_client.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> login(String username, String password);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<UserModel?> login(String username, String password) async {
    UserModel? userModel;

    final response = await dioClient.dio.post(
      '/auth/login',
      data: {"username": username, "password": password},
    );

    log(response.statusCode.toString());
    log(response.data.toString());

    if (response.statusCode == HttpStatus.ok) {
      final token = response.data['token'];

      if (token != null) {
        await getIt<SharedPreferencesManager>().saveToken(token);
      }
      // get user details from api by making a get request to /users/userId
      final userDetailsResponse = await dioClient.dio.get(
        '/users/${response.data['id']}',
      );

      log(userDetailsResponse.statusCode.toString());
      log(userDetailsResponse.data.toString());

      if (userDetailsResponse.statusCode == HttpStatus.ok &&
          userDetailsResponse.data != null) {
        userModel = UserModel.fromJson(userDetailsResponse.data);
        await getIt<SharedPreferencesManager>().saveUser(userModel);
      } else {
        throw Exception("Failed to login");
      }
    }

    return userModel;
  }
}
