import 'dart:async';

var eventStream = new StreamController();

Stream<String> mapTo() async* {
  await for (var event in eventStream.stream) {
    print(event);
    await Future.delayed(Duration(seconds: 3));
    yield event;
  }
}

void main() async {
  var str = mapTo();

  var sub = str.listen((event) {
    print("$event ok");
  });

  eventStream.sink.add("Login");
}
/*
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // -1

*/
/*

    Stream<LoginState> mapEventToState(){

    }

  Stream
    EventStream->StateStream

    EventStream.add(Event);

    StreamBuilder(
      stream:StateStream.stream
    );


*/
