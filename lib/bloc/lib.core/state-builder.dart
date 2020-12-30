import 'dart:async';

import 'bloc-interface.dart';

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
