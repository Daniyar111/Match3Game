import 'package:flutter/material.dart';

import 'level.dart';
import 'tile_type.dart';

class Tile{

  TileType type;
  int row;
  int col;
  Level level;
  int depth;
  Widget _widget;
  double x;
  double y;
  bool visible;


  Tile({
    this.type,
    this.row = 0,
    this.col = 0,
    this.level,
    this.depth = 0,
    this.visible = true
  });

  @override
  int get hashCode => row * ;
}