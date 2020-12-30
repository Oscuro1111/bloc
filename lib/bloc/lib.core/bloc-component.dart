import 'dart:async';

import 'state-builder.dart';
import './bloc-interface.dart';
import './plugin-interface.dart';

abstract class BlocComponent<E extends Event, S extends BlocState>
    extends BlocBase<S> {
  BlocComponent() {
    _blocState = new StateBuilder<E, S>(eventHandler: eventHandler);
  }

  StateBuilder _blocState;

  StateBuilder<E, S> get loginState => _blocState;

  ///Listent to Data event [StateBuilder]
  Stream<S> get stream => _blocState.strem;

  ///Dispatch events to event stream for state change .
  Function(E) get add => _blocState.add;

  // ignore: deprecated_member_use
  final _listeners = new List<Plugin<E, S>>();

  void addListener(Plugin handle) {
    _listeners.add(handle);
  }

  void removeListener(Plugin handle) {
    _listeners.remove(handle);
  }

  @override
  void dispose() {
    _blocState.dispose();
  }

  ///Map Event from event stream to state stream.
  Future<S> mapEventToState(E event, EventSink<S> sink);

  void eventHandler(Event event, EventSink<S> sink) {
    var resultState = mapEventToState(event, sink);

    resultState.then((state) {
      _listeners.forEach((Plugin plugin) {
        plugin.mapEventToState(event, sink, state);
      });
    });
  }
}

abstract class Bloc<E extends Event, S extends BlocState>
    extends BlocComponent<E, S> {
  Bloc() : super();

  void close(int seconds) {
    Future.delayed(Duration(seconds: seconds), () => super.dispose());
  }

  @override
  Future<S> mapEventToState(E event, EventSink<S> sink) async {
    sink.add(null);

    var state = await eventMapToState(event);

    sink.add(state);

    return state;
  }

  void dispose();

  Future<S> eventMapToState(E event);
}
