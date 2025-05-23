import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fake_store/domain/entities/user.dart' show User;
import 'package:fake_store/domain/repositories/auth_repository.dart';

part 'auth_bloc.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({
    required String username,
    required String password,
  }) = _Login;
}

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(User user) = _Success;
  const factory AuthState.error(String error) = _Error;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(const AuthState.initial()) {
    // login event
    on<_Login>((event, emit) async {
      emit(const AuthState.loading());
      try {
        final user = await repository.login(event.username, event.password);
        if (user != null) {
          emit(AuthState.success(user));
        } else {
          emit(const AuthState.error("Login error"));
        }
      } catch (e) {
        emit(AuthState.error(e.toString()));
      }
    });
  }
}
