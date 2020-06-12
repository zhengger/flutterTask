
import 'course.dart';

void main(){
  final English english= English();
  final Mathematica math=Mathematica();
  final Geometric geometric=Geometric();
  print("Math course page count is ${math.pages}");
  // The getter '_owner' isn't defined for the class 'Math'
  // print("Math course owner is ${math._owner}");
  print("Math course owner is ${geometric.owner}");
  print("English course page count is ${english.pages}");
}

