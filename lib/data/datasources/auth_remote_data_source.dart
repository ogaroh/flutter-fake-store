import 'dart:developer';
import 'dart:io';

import 'package:injectable/injectable.dart';
import '../models/user_model.dart';
import '../../core/network/dio_client.dart';

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
      '/users',
      data: {"username": username, "password": password},
    );

    log(response.statusCode.toString());
    log(response.data.toString());

    if (response.statusCode == HttpStatus.ok) {
      // get user details from api by making a get request to /users/userId
      final userDetailsResponse = await dioClient.dio.get(
        '/users/${response.data['id']}',
      );

      log(userDetailsResponse.statusCode.toString());
      log(userDetailsResponse.data.toString());

      if (userDetailsResponse.statusCode == HttpStatus.ok &&
          userDetailsResponse.data != null) {
        userModel = UserModel.fromJson(userDetailsResponse.data);
      } else {
        throw Exception("Failed to login");
      }
    }

    return userModel;
  }
}
