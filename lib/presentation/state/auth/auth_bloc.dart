import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../data/datasources/local/shared_preferences_manager.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  final SharedPreferencesManager _prefsManager;

  AuthBloc(this.repository, this._prefsManager) : super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  // login request
  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await repository.login(event.username, event.password);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(const AuthError("Login error"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // logout request
  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    log('Logout requested');
    await _prefsManager.clearAuthData();
    emit(const AuthLogoutSuccess());
  }
}
