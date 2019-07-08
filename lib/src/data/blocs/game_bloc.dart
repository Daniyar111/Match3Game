import 'package:match3_game/src/data/controllers/game_controller.dart';
import 'package:match3_game/src/data/providers/bloc_provider.dart';
import 'package:match3_game/src/models/level.dart';
import 'package:match3_game/src/models/objective_event.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc extends BlocBase{

  // Controller that emits a boolean value to trigger the display of the tiles at game as load is ready.
  // This is done as soon as this Bloc receives the dimensions/position of the board as well as the dimensions of a tile.

  BehaviorSubject<bool> _readyToDisplayTileController = BehaviorSubject<bool>();
  Function get setReadyToDisplayTiles => _readyToDisplayTileController.sink.add;
  Stream<bool> get outReadyToDisplayTiles => _readyToDisplayTileController.stream;


  // Controller aimed at processing the Objective events

  PublishSubject<ObjectiveEvent> _objectiveEventsController = PublishSubject<ObjectiveEvent>();
  Function get sendObjectiveEvent => _objectiveEventsController.sink.add;
  Stream<ObjectiveEvent> get outObjectiveEvents => _objectiveEventsController.stream;


  // Controller that emits a boolean value to notify that a game is over
  // the boolean value indicates whether the game is won (true) or lost (false)

  PublishSubject<bool> _gameIsOverController = PublishSubject<bool>();
  Stream<bool> get gameIsOver => _gameIsOverController.stream;


  // Controller that emits the number of moves left for the game

  PublishSubject<int> _movesLeftController = PublishSubject<int>();
  Stream<int> get movesLeftCount => _movesLeftController.stream;


  // List of all level definitions

  List<Level> _levels = <Level>[];
  int _maxLevel = 0;
  int _levelNumber = 0;

  int get levelNumber => _levelNumber;
  int get numberOfLevels => _maxLevel;


  // The controller for the Game being played

  GameController _gameController;
  GameController get gameController => _gameController;


  // Constructor

  GameBloc(){
    // Load all levels definitions
    _loadLevels();
  }



  // The user wants to select a level.
  // We validate the level and emit the requested Level.

  // We use the [async] keyword to allow the caller to use a Future.

  // e.g. bloc.setLevel((1).then(() => ...);
  // Todo: need to finish
  Future<Level> setLevel(int levelIndex) async {

    _levelNumber = (levelIndex - 1).clamp(0, _maxLevel);

    // Initialize the Game
    _gameController = GameController();

    // Fill the Game with Tile and make sure there are possible Swaps

    return _levels[_levelNumber];
  }


  // Load the levels definitions from assets

  _loadLevels() async {


  }


  @override
  void dispose() {
    _readyToDisplayTileController?.close();
    _objectiveEventsController?.close();
    _gameIsOverController?.close();
    _movesLeftController?.close();
  }

}