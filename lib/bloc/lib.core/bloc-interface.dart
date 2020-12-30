abstract class Store<T extends BlocState> {
  T store;

  T setStoreSync(void Function(T store) changeState) {
    changeState(this.store);

    return this.store.clone();
  }

  Future<T> setStoreAsync(Future<void> Function(T store) changeState) async {
    await changeState(this.store);

    return this.store.clone();
  }
}

abstract class BlocBase<T extends BlocState> extends Store<T> {
  void initState(T store) {
    this.store = store;
  }

  void dispose();
}

abstract class BlocState<T> {
  T clone();
}

abstract class Event {}

abstract class DataService {}

abstract class Reducer {}
