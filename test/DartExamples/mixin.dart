/// Animal抽象类不能被实例化，但可以包含某些方法实现，如run()
abstract class Animal {
  String name;
  Animal(this.name);
  String get noise;
  String eat(){
    return "eats sth";
  }
}
/// Bird继承于Animal抽象类，需要实现noise Getter，并可以复用Animal类的eat方法
class Bird extends Animal {
  Bird(String name) : super(name);
  String get noise => 'tweet';
}
/// Pikachu类实现Animal接口，需实现name实例字段，noise Getter，以及重定义eat方法
class Pikachu implements Animal {
  String name = 'Pikachu';
  String get noise => 'pika';
  @override
  String eat() {
    return "eats nothing";
  }
}
/// Swimmer为mixin类，不能定义构造函数
mixin  Swimmer {
  String swim() {
    return "can swimming";
  }
}
/// 没有默认构造函数的抽象类也可以用于混入
abstract class Flyer {
  // 不能直接被派生extends
  factory Flyer._() => null;
  String fly() {
    return "can flying";
  }
}
/// Duck类继承于Bird类，并具有Swimmer和Flyer的功能
class Duck extends Bird with Swimmer, Flyer {
  Duck(String name) : super(name);
  String get noise => 'duckling';
}

main() {
  var magpie = new Bird('Magpie');
  var pika = new Pikachu();
  var bufflehead = new Duck("Bufflehead");
  print('${magpie.name} noise is ${magpie.noise}, ${magpie.eat()}.');
  print('${pika.name} noise is ${pika.noise}, ${pika.eat()}.');
  print('${bufflehead.name} noise is ${bufflehead.noise}, ${bufflehead.eat()}, '
      '${bufflehead.swim()}, ${bufflehead.fly()}.');
}

