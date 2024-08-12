part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginStart extends LoginEvent{
  String userName;
  String password;

  LoginStart({required this.userName, required this.password});


}

final class LogoutRequest extends LoginEvent{

 

}

  

