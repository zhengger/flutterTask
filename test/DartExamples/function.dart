double area (double length , [double width]){
  if (width==null) return length*length;
  else return length*width;
}
double volume (double length, {double width, double height} ){
  if (width==null&&height==null) return length*length*length;
  else return length*width*height;
}
void main(){
  print("area1 is ${area(10)}");
  print("area2 is ${area(10,20)}");
  print("volumn1 is ${volume(10)}");
  print("volumn2 is ${volume(10,height:30,width: 20)}");


}