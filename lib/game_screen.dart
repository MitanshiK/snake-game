import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/constants/constants.dart';
import 'package:snake_game/exp.dart';
import 'package:snake_game/snake_ui/snake_component_class.dart';
import 'package:snake_game/snake_ui/snake_parts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

Food food = Food(position: 0, offset: Offset.zero);
BigFood bigFood=BigFood(position: 0, offset: Offset.zero);
bool start=false;
bool dead=false;
bool deathFlicker=false;
Direction direction=Direction.right;
int score=0;
int bigFoodShowCounter=0;
var snakeBodys=[];  // contains blocks of snake body
Timer? timer;  // to update snake position
List<int> totSpot =List.generate(770, (int index)=> (index));  // total spots in the board where snake can go

@override
  void initState() {
   initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:GestureDetector(

        // for verticle movement
        onVerticalDragUpdate: (details) {
         if(dead){
          return;
         } 

       if(start){ 
         // for down
         if(direction!= Direction.up && details.delta.dy>0){
          if(direction!=Direction.down && direction !=Direction.up){
            direction=Direction.down;
            print("down");
          }
         }
         // for up
         else if(direction!= Direction.down  &&  details.delta.dy < 0){
          if(direction!=Direction.down && direction !=Direction.up){
            direction=Direction.up;
            print("up");
          }
         }else{
          startGame();
         }}
        },

        // for horizontal movement
        onHorizontalDragUpdate:(details) {
         if(dead){
          return;
         } 

       if(start){ 
         // for right
         if(direction!= Direction.left && details.delta.dx>0){
          if(direction!=Direction.right && direction !=Direction.left){
            direction=Direction.right;
            print("right");
          }
         }
         // for left
         else if(direction!= Direction.right  &&  details.delta.dx < 0){
          if(direction!=Direction.right && direction !=Direction.left){
            direction=Direction.left;
            print("left");
          }
         }else{
          startGame();
         }}


        } ,
        child: RepaintBoundary(
          child:
          ///
           RepaintBoundary(
              child: Center(
                child: SizedBox(
                  width: 450,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 32,
                          ),
                          Text(
                            score.toString().padLeft(4, "0"),
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          if (bigFood.show)
                            Text(
                              bigFood.time.toString().padLeft(2, "0"),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                            ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        child: Divider(
                          thickness: 4,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 4,
                        )),
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 2)), // inner
                          constraints: const BoxConstraints(
                              maxWidth: 352 + 16,
                              minWidth: 352 + 16,
                              maxHeight: 560 + 16,
                              minHeight: 560 + 16),
                          child: Center(
                            child: Stack(
                              children: [
                                ...List.generate(
                                    snakeBodys.length,
                                    (index) => Visibility(
                                          visible: !deathFlicker,
                                          replacement: const SizedBox(),
                                          child: Positioned(
                                              left: snakeBodys[index].offset.dx,
                                              top: snakeBodys[index].offset.dy,
                                              child: getSnakeBody(
                                                  snakeBodys[index],
                                                  index,
                                                  snakeBodys.length)),
                                        )),
                                Positioned(
                                    left: food.offset.dx,
                                    top: food.offset.dy,
                                    child: normalFood),
                                if (bigFood.show)
                                  Positioned(
                                      left: bigFood.offset.dx,
                                      top: bigFood.offset.dy,
                                      child: geekFood),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        child: Divider(
                          thickness: 4,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 32,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: FittedBox(
                                    child: Image(image: AssetImage("assets/catfood.png")),
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                food.count.toString().padLeft(3, "0"),
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image(
                                    image: AssetImage("assets/superCatFood.png"),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.none,
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                bigFood.count.toString().padLeft(3, "0"),
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                    ],
                  ),

                  
                ),
              ),
            ),
          ///
        ),
      ),
    );
  }

 Widget getSnakeBody(SnakeBody snake, int index, int length) {
  index = index + 1;

if (index == 1) {

return RotatedBox(

quarterTurns: snake.direction == Direction.down

? 1
            : snake.direction == Direction.up
? -1
                : snake.direction == Direction.left
                    ? 2
                    : 0,
        child: tail);
  } else if (index == length) {
    return RotatedBox(
        quarterTurns: snake.direction == Direction.down
            ? 1
            : snake.direction == Direction.up
                ? -1
                : snake.direction == Direction.left
                    ? 2
                    : 0,
        child: openMouth(snake.position, food.position, 
snake.direction)
            ? eatingHead
            : snakeHead);
  } else {
    return normalBody;
  }
}

bool openMouth(int pos , int foodPos, Direction direction){
 int nextpos=0;

if(foodPos== pos){
  return true;
}

 switch(direction){
  case Direction.down: {
   if(pos > 748){
   nextpos=pos - 770 + xcount;
   }else{
    nextpos=pos+ xcount;
   }
  }
  case Direction.up: {
    if(pos < xcount){
      nextpos=pos + 770 -xcount;
    }
    else{
    nextpos=pos-xcount;
    }
  }
  case Direction.right: {
    if((pos+1)%xcount==0){
      nextpos=pos + 1 - xcount;
    }else{
      nextpos=pos+1;
    }
  }
  case Direction.left: {
    if(pos % xcount == 0){
     nextpos=pos -1 +xcount;
    }else{
      nextpos=pos-1;
    }
  }
  default:
 }
 if(snakeBodys.map((e) => e.position).toList().contains(nextpos)){
  return true;
 }else{
  return (nextpos == foodPos || (bigFood.show && bigFood.position==nextpos) );
 }

}

//////// to define
void startGame(){

 start=true;
 initialize();
 
 if(timer!= null){
  timer!.cancel();
 }

 

}

  void  initialize() {

 snakeBodys = [
SnakeBody(

position: 100,

direction: Direction.right,

offset: getOffsetforPos(100),

),

SnakeBody(

position: 101,

direction: Direction.right,

offset: getOffsetforPos(101),

),

SnakeBody(

position: 102,

direction: Direction.right,

offset: getOffsetforPos(102),

),

SnakeBody(

position: 103,

direction: Direction.right,

offset: getOffsetforPos(103),

),

SnakeBody(

position: 104,

direction: Direction.right,

offset: getOffsetforPos(104),

),

SnakeBody(

position: 105,

direction: Direction.right,

offset: getOffsetforPos(105),

),

];

do{
  food.position=Random().nextInt(770);
}while([100,101,102,103,104,105].contains(food.position));
  direction=Direction.right;
  food.count=0;
  food.offset=getOffsetforPos(food.position);
 totSpot=List.generate(770, (int index)=> index); 
  }

updateSnake()

 {
  setState(() {
     switch(direction){
      case Direction.down :{
      if(snakeBodys.last.position > 748){  
        snakeBodys.add(
          SnakeBody( 
            position: snakeBodys.last.position - 770 + xcount,
             direction: direction,
              offset: getOffsetforPos(snakeBodys.last.position - 770 + xcount) ));
      }else{
        snakeBodys.add(SnakeBody(position: snakeBodys.last.position + xcount,
         direction: direction
         , offset: getOffsetforPos(snakeBodys.last.position + xcount)));
      }
      }
      case Direction.up :{
        if(snakeBodys.last.pos < xcount){ 
          snakeBodys.add(SnakeBody(position: snakeBodys.last.position +770 -xcount,
           direction: direction,
            offset: getOffsetforPos(snakeBodys.last.position +770 -xcount)));
        }else{
          snakeBodys.add(SnakeBody(position: snakeBodys.last.position-xcount,
           direction: direction,
            offset: getOffsetforPos( snakeBodys.last.position-xcount)));
        }
          }
        case Direction.right:
          {
            if ((snakeBodys.last.positon + 1) % xcount == 0) {
              snakeBodys.add(SnakeBody(
                  position: snakeBodys.last.position + 1 - xcount,
                  direction: direction,
                  offset:
                      getOffsetforPos(snakeBodys.last.position + 1 - xcount)));
            }else{
              snakeBodys.add(SnakeBody(position: snakeBodys.last.position -xcount,
               direction: direction,
                offset: getOffsetforPos(snakeBodys.last.position -xcount)
                ));
            }
          }
        case Direction.left :{
          if(snakeBodys.last.position % xcount == 0){
            snakeBodys.add(SnakeBody(position: snakeBodys.last.position -1 + xcount,
             direction: direction,
              offset: getOffsetforPos(snakeBodys.last.position -1 + xcount)));
          }else{
            snakeBodys.add(SnakeBody(position: snakeBodys.last.position + xcount,
             direction: direction,
              offset: getOffsetforPos(snakeBodys.last.position + xcount)));
           }
          }
        default:
      }
    });
  }
}
