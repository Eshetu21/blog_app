import 'package:blog_app/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_log_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogIn userLogIn,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogIn = userLogIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _userSignUp.call(UserSignUpParams(
          name: event.name, email: event.email, password: event.password));
      res.fold((l) => emit(AuthFailure(l.message)),
          (user) => _emitAuthSucess(user, emit));
    });
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final res = await _userLogIn
          .call(UserLoginParams(email: event.email, password: event.password));
      res.fold((l) => emit(AuthFailure(l.message)),
          (user) => _emitAuthSucess(user, emit));
    });
    on<AuthIsUserLoggedIn>((event, emit) async {
      emit(AuthLoading());
      final res = await _currentUser(NoParams());
      res.fold(
          (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSucess(r, emit));
    });
  }
  void _emitAuthSucess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSucess(user));
  }
}
