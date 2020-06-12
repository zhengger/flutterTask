class Rectangle {
  num left, top, width, height;
  Rectangle(this.left, this.top, this.width, this.height);
  // 定义两个计算产生的属性：right 和 bottom。
  num get right => left + width;
  set right(num value) => left = value - width;
  num get bottom => top + height;
  set bottom(num value) => top = value - height;
  // 定义一个面积属性
  double get area {
    return width*height;
  }
}
void main() {
  var rect = Rectangle(3, 4, 20, 15);
  var position=rect.right;  //此时调用get right
  rect.right = 12; //此时调用set right
}