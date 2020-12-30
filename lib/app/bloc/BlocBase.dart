import 'dart:async';

import 'package:proj_dec/bloc/bloc.dart' show Bloc, BlocState, Event, Future;

class Login extends Event {}

class LoginOut extends Event {}

class Close extends Event {}

class LoginState extends BlocState<LoginState> {
  LoginState({this.login: false, this.loading: false, this.closed: false});

  bool login;
  bool loading;
  bool closed;

  @override
  LoginState clone() {
    LoginState cloneObj = new LoginState(
        loading: this.loading, login: this.login, closed: this.closed);
    return cloneObj;
  }
}

class Log extends Bloc<Event, LoginState> {
  Log() : super() {
    this.initState(new LoginState(loading: false, login: false, closed: false));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<LoginState> eventMapToState(Event event) async {
    if (event is LoginOut) {
      //Intentional delay
      await Future.delayed(Duration(seconds: 5), () => null);

      var state = this.setStoreSync((LoginState store) {
        store.login = true;
      });

      return state;
    }

    if (event is Login) {
      //Intentional delay
      await Future.delayed(Duration(seconds: 5), () => null);

      var state = this.setStoreSync((store) {
        store.login = false;
      });

      return state;
    }

    return null;
  }
}
