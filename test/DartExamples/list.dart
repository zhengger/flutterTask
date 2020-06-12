
void main() {

  var numbers = [1,2,3,4,5];

  numbers
  .where((number) => number.isEven)
  .forEach((number) => print(number));

}