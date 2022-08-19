abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthOverlayLoadingState extends AuthStates {}

class AuthSignUpLoadingState extends AuthStates {}

class AuthSignUpSuccessState extends AuthStates {}

class AuthSignUpFailureState extends AuthStates {
  final String? error;

  AuthSignUpFailureState(this.error);
}

class AuthSignInLoadingState extends AuthStates {}

class AuthSignInSuccessState extends AuthStates {}

class AuthSignInFailureState extends AuthStates {
  final String? error;

  AuthSignInFailureState(this.error);
}
