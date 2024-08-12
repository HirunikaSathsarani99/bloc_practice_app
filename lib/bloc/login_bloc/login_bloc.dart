import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginStart) {
        if (state is LoginSucess) {
          emit(state);
          return;
        }
        emit(LoginLoading());

        bool loginResult =
            await LoginRepository().login(event.userName, event.password);
        if (loginResult) {
          emit(LoginSucess());
        } else {
          emit(LoginFail());
        }
      } else if (event is LogoutRequest) {
        emit(Logout());
      }
    });
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    try {
      final isLoggedIn = json['isLoggedIn'] as bool;
      if (isLoggedIn) {
        return LoginSucess();
      } else {
        return Logout();
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    if (state is LoginSucess) {
      return {'isLoggedIn': true};
    } else if (state is Logout) {
      return {'isLoggedIn': false};
    }
    return null;
  }
}
