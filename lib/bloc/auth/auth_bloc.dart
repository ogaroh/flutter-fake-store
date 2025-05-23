import 'package:fake_store/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(event.username, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthError("Login error"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }
}
