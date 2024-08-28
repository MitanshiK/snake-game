import 'package:flutter/material.dart';

// normal head
Widget snakeHead = Container(
  decoration: const BoxDecoration(),
  height: 16,
  width: 16,
  child: Row(
    children: [
      //1
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
            transform: Matrix4.translationValues(0, -6, 0)
          ),
              Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
          )
        ],
      ),
      //2
            Column(
        children: [
          Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
          ),
              Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
          )
        ],
      ),
    ],
  ),
);

// tail
Widget tail=Container(
  width: 16,
  height: 16,
  decoration: const BoxDecoration(),
  child: Row(
    children: [
      //1 block
      Container(
        width: 6,
        height: 6,
            margin: EdgeInsets.all(1),
        decoration: const BoxDecoration(color: Colors.black),
      ),
      //2
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
          ),
           Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
           )
        ],
      )
    ],
  ),
);

//openMouth
Widget eatingHead=Container(
  width: 16,
  height: 16,
  child: Row(children: [
    // transformed
          Column(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: Colors.black),
            transform: Matrix4.translationValues(0,-4 , 0),
          ),
           Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: Colors.black),
             transform: Matrix4.translationValues(0,4 , 0),
           )
        ],
      ),
      //2
        Column(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: Colors.black),
          ),
           Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: Colors.black),
           )
        ],
      )
  ],),
);

//normal body
Widget normalBody=Container(
  width: 16,
  height: 16,
  child: Row(children: [
    // 1
          Column(
        children: [
          Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
          ),
           Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
           )
        ],
      ),
      //2
        Column(
        children: [
          Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
          ),
           Container(
            width: 6,
            height: 6,
                margin: EdgeInsets.all(1),
            decoration: const BoxDecoration(color: Colors.black),
           )
        ],
      )
  ],),
);

// food
Widget normalFood=Container(
  height: 25,
  width: 25,
  child: const FittedBox(
    fit: BoxFit.contain,
    child: Image(image: AssetImage("assets/catfood.png"),),
  ),
);

Widget geekFood=Container(
  height: 25,
  width: 25,
  child: const FittedBox(
    fit: BoxFit.contain,
    child: Image(image: AssetImage("assets/superCatFood.png"),),
  ),
);