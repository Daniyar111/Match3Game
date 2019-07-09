import 'dart:math' show Random;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'level.dart';
import 'tile_type.dart';

class Tile extends Object{

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
  int get hashCode => row * level.numberOfRows + col;

  @override
  bool operator ==(other) {
    return identical(this, other) || other.hashCode == this.hashCode;
  }

  @override
  String toString() {
    return '[$row][$col] => ${describeEnum(type)}';
  }


  // Build the tile in terms of 'decoration' ( = image)

  void build({bool computePosition = true}){

    if(depth > 0 && type != TileType.wall){
      _widget = Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.7,
            child: Transform.scale(
              scale: 0.8,
              child: _buildDecoration(),
            ),
          ),
          _buildDecoration('deco/ice_02.png')
        ],
      );
    }
    else if(type == TileType.empty){
      _widget = Container();
    }
    else{
      _widget = _buildDecoration();
    }

    if(computePosition){
      setPosition();
    }
  }

  Widget _buildDecoration([String path = '']){
    String imageAsset = path;
    if(imageAsset == ''){
      switch(type){
        case TileType.wall:
          imageAsset = 'deco/wall.png';
          break;
        case TileType.bomb:
          imageAsset = 'bombs/mine.png';
          break;
        case TileType.flare:
          imageAsset = 'bombs/tnt.png';
          break;
        case TileType.wrapped:
          imageAsset = 'tiles/multicolor.png';
          break;
        case TileType.fireball:
          imageAsset = 'bombs/rocket.png';
          break;
        default:
          try{
            imageAsset = 'tiles/${describeEnum(type)}.png';
          } catch(e){
            return Container();
          }
          break;
      }
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$imageAsset'),
          fit: BoxFit.contain
        ),
      ),
    );
  }


  // Returns the position of this tile in the checkerboard based on its position in the grid (row, col)
  // and the dimension of the board and a tile

  void setPosition(){
    double bottom = level.boardTop + (level.numberOfRows - 1) * level.tileHeight;
    x = level.boardLeft + col * level.tileWidth;
    y = bottom - row * level.tileHeight;

//    print('Tile class setPosition level.boardTop ${level.boardTop}, '
//        'level.boardLeft ${level.boardLeft}, '
//        'level.numberOfRows ${level.numberOfRows}, '
//        'level.numberOfCols ${level.numberOfCols}, '
//        'level.tileHeight ${level.tileHeight}, '
//        'level.tileWidth ${level.tileWidth}, '
//        'col $col, row $row, x $x, y $y');
  }


  // Generate a tile to be used during the swap animations

  Tile cloneForAnimation(){
    Tile tile = Tile(level: level, type: type, row: row, col: col);
    tile.build();

    return tile;
  }


  // Swaps this tile (row, col) with the ones of another Tile

  void swapRowColWith(Tile destTile){
    int tft = destTile.row;
//    print('Tile class swapRowColWith tft $tft, destTile.row ${destTile.row}');
    destTile.row = row;
//    print('Tile class swapRowColWith destTile.row ${destTile.row}, row $row');
    row = tft;

    tft = destTile.col;
//    print('Tile class swapRowColWith tft $tft, destTile.col ${destTile.col}');
    destTile.col = col;
//    print('Tile class swapRowColWith destTile.col ${destTile.col}, row $col');
    col = tft;
  }


  // Returns the Widget to be used to render the Tile

  Widget get widget => getWidgetSized(level.tileWidth, level.tileHeight);

  Widget getWidgetSized(double width, double height){
    return Container(
      width: width,
      height: height,
      child: _widget,
    );
  }


  // Can the tile move?

  bool get canMove => (depth == 0) && (canBePlayed(type));


  // Can a Tile fall?

  bool get canFall => type != TileType.wall && type != TileType.forbidden && type != TileType.empty;



  /// HELPERS


  static int get _firstNormalTile => TileType.red.index;
  static int get _lastNormalTile => TileType.yellow.index;
  static int get _firstBombTile => TileType.bomb.index;
  static int get _lastBombTile => TileType.fireball.index;


  // Generate a random Tile

  static TileType random(Random random){
    int minValue = _firstNormalTile;
    int maxValue = _lastNormalTile;
    int value = random.nextInt(maxValue - minValue) + minValue;
    return TileType.values[value];
  }

  static bool isNormal(TileType type){
    int index = type.index;
    return (index >= _firstNormalTile && index <= _lastNormalTile);
  }

  static bool isBomb(TileType type){
    int index = type.index;
    return (index >= _firstBombTile && index <= _lastBombTile);
  }

  static bool canBePlayed(TileType type) => (type != TileType.wall && type != TileType.forbidden);
}