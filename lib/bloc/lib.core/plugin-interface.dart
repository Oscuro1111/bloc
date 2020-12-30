import 'dart:async';

import './bloc-interface.dart';

abstract class Plugin<I extends Event, O extends BlocState> {
  Future<void> mapEventToState(I event, EventSink<O> sink, O state);
}
