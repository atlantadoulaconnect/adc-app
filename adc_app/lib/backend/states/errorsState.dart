import 'common.dart';

@immutable
class ErrorsState {
  final String loginError; // none if no error, other error reason
  final String signupError;

  ErrorsState({this.loginError, this.signupError}) {
    print(toString());
  }

  static ErrorsState initialState() {
    return ErrorsState(loginError: "none", signupError: "none");
  }

  ErrorsState copy({String loginError, String signupError}) {
    return ErrorsState(
        loginError: loginError ?? this.loginError,
        signupError: signupError ?? this.signupError);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorsState &&
          runtimeType == other.runtimeType &&
          loginError == other.loginError &&
          signupError == other.signupError;

  @override
  int get hashCode => loginError.hashCode ^ signupError.hashCode;

  @override
  String toString() {
    return 'ErrorsState{loginError: $loginError, signupError: $signupError}';
  }
}
