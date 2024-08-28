import 'dart:ui';

import 'package:snake_game/constants/constants.dart';

class SnakeBody{
 int position=100;
 Direction direction = Direction.right;
 Offset offset= Offset.zero;

SnakeBody({required this.position,required this.direction,required this.offset });
}


class Food{
 int position=100;
int count=0;
 Offset offset= Offset.zero;

Food({required this.position,required this.offset });
}

class BigFood {
  int position = 0;
  Offset offset = Offset.zero;
  int count = 0;
  bool show = false;
  int time = 40;
  BigFood({
    required this.position,
    required this.offset,
  });
}