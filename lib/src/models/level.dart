
import 'package:match3_game/src/utils/array_2d.dart';

/// Level
///
/// Definition of a level in terms of:
///  - grid template
///  - maximum number of moves
///  - number of columns
///  - number of rows
///  - list of objectives

class Level{

  final int _index;
  Array2d grid;
  final int _rows;
  final int _columns;
  List<Objective> _objectives;

}