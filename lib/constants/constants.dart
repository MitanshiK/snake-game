import 'dart:ui';

int xcount = 22, ycount = 35;
double cellSize = 16;

enum Direction {
  left,
  right,
  up,
 down
}

Map<int,int> speeds={
  1:400,
  2:350,
  3:300,
  4:250,
  5:200,
  6:150,
  7:100
};


Offset getOffsetforPos(int pos) {
return Offset(
((pos % xcount) * 16) + 8, ((pos ~/ xcount % ycount) * 16)
+ 8);

}