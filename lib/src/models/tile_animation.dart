import 'row_col.dart';
import 'tile.dart';
import 'tile_animation_type.dart';
import 'tile_type.dart';

///
/// TileAnimation
///
/// Class which is used to register a Tile animation
class TileAnimation{

  final TileAnimationType animationType;
  final int delay;
  final RowCol from;
  final RowCol to;
  final TileType tileType;
  Tile tile;

  TileAnimation({
    this.animationType,
    this.delay,
    this.from,
    this.to,
    this.tileType,
    this.tile,
  });
}