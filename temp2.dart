import 'dart:async';

//Bloc

abstract class Event {}

class Login extends Event {}

class LoginOut extends Event {}

enum LoginEventTypes { logined, loading }

abstract class BlocState {}

class LoginEvent extends Event {
  LoginEvent() : type = LoginEventTypes.logined;
  LoginEventTypes type;
}

class LoginState extends BlocState {
  LoginState({this.login: false, this.loading: false});

  bool login;
  bool loading;
}

class StateBuilder<I extends Event, O extends BlocState> {
  StateBuilder({this.eventHandler}) {
    this._streamController = new StreamController.broadcast();
    this._stream = this._streamController.stream.transform(
        StreamTransformer<I, O>.fromHandlers(handleData: eventHandler));
  }

  final void Function(I event, EventSink<O> sink) eventHandler;

  StreamController<I> _streamController;

  Stream<O> _stream;

  Stream<O> get strem => _stream;

  Function(Event) get add => _streamController.sink.add;

  void dispose() {
    _streamController.close();
  }
}

abstract class Bloc {
  void dispose();
}

abstract class BlocComponent<E extends Event, S extends BlocState>
    extends Bloc {
  BlocComponent() {
    _blocState = new StateBuilder<E, S>(eventHandler: eventHandler);
  }

  StateBuilder _blocState;

  StateBuilder<E, S> get loginState => _blocState;

  Stream<S> get stream => _blocState.strem;

  Function(E) get add => _blocState.add;

  @override
  void dispose() {
    _blocState.dispose();
  }

  Future<void> mapEventToState(E event, EventSink<S> sink);

  void eventHandler(Event event, EventSink<S> sink) {
    mapEventToState(event, sink);
  }
}

class LoginBloc extends BlocComponent<Event, LoginState> {
  LoginBloc() : super();

  @override
  Future<void> mapEventToState(Event event, EventSink<LoginState> sink) async {
    if (event is Login) {
      //processing
      sink.add(new LoginState(login: true));
    }
  }
}

/*
void main() {
  var instance = new LoginBloc();

  instance.stream.listen((event) {
    print(event.login);
  });

  instance.add(Login());
}
*/
