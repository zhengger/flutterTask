class Test<T> {
  T obj;
  Test(T obj) {
    this.obj = obj;
  }
  T getObject() {
    return this.obj;
  }
}
main() {
  Test<String> t1 = Test<String>("Hello World");
  print(t1.getObject());
  Test<double> t2 = Test<double>(3.14);
  print(t2.getObject());
}