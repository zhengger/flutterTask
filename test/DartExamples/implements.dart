// Person 类的隐式接口中包含 greet() 方法和 name 实例变量。
class Person {
  final name="";
  // greet() 方法在接口中。
  String greet(String who) => '你好，$who。我是$name。';
}
//class SomeBody implements Person{
//
//}
// provide an implementation
class Asian implements Person {
  var name="groupones";
  String greet(String sth){
    return "Hello Asian";
  }
}
// inherit an implementation from  mixin
class American with Person {

}
// mark the class as abstract
abstract class European implements Person{

}
// provide a 'noSuchMethod' implementation
class African implements Person {
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }
}
void main() {
  
}