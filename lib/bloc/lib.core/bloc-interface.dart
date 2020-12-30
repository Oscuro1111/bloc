abstract class Store<T extends BlocState> {
  T store;

  ///Directly updating the local state .Must not use async,await inside. use [setStoreAync] insted if required api call from async source inside function providing store.
  T setStoreSync(void Function(T store) changeState) {
    changeState(this.store);

    return this.store.clone();
  }

  ///This method used if data is fetched from async source like server inside that method
  Future<T> setStoreAsync(Future<void> Function(T store) changeState) async {
    await changeState(this.store);

    return this.store.clone();
  }
}

abstract class BlocBase<T extends BlocState> extends Store<T> {
  ///Initialize it with state instance  need to manage.
  void initState(T store) {
    this.store = store;
  }

  ///closing streams connection.
  void dispose();
}

///Must be implemented for state need to manage .
abstract class BlocState<T> {
  T clone();
}

///Every event must implement it.
abstract class Event {}

abstract class DataService {}
