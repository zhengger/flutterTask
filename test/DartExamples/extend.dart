class Student{
  var name="groupones";
  var _age=18;
  String study()=> "studying";

}

class College extends Student{
  String intern()=> "interning!";
}

void main(){
  College c = College();
  print("${c.name} is ${c.intern()}");

  print("${c._age}");
}