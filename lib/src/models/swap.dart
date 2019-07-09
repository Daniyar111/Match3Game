import 'package:match3_game/src/models/tile.dart';

/// Swap
///
/// Identifies a possible swap between two tiles

class Swap extends Object{

  Tile from;
  Tile to;

  Swap({
    this.from,
    this.to
  });


  @override
  int get hashCode => from.hashCode * 1000 + to.hashCode;


  @override
  bool operator ==(other) {
    return identical(this, other) || other.hashCode == this.hashCode;
  }
}