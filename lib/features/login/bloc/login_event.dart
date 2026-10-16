import 'package:equatable/equatable.dart';

/// Events for the [LoginBloc].
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// Emitted when the user modifies the email input.
final class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

/// Emitted when the user modifies the password input.
final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

/// Emitted when the login form is submitted.
final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
