import 'package:flutter/material.dart';
import 'package:match3_game/src/data/blocs/game_bloc.dart';
import 'package:match3_game/src/data/providers/bloc_provider.dart';
import 'package:match3_game/src/models/level.dart';

import 'stream_moves_left_counter.dart';

class GameMovesLeftPanel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final GameBloc gameBloc = BlocProvider.of<GameBloc>(context);

    final Level level = gameBloc.gameController.level;

    final Orientation orientation = MediaQuery.of(context).orientation;
    
    final EdgeInsets paddingTop = EdgeInsets.only(top: (orientation == Orientation.portrait ? 10.0 : 0.0));

    return Padding(
      padding: paddingTop,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300].withOpacity(0.7),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 5.0, color: Colors.black.withOpacity(0.5)),
        ),
        width: 100.0,
        height: 80.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Level: ${level.index}',
                  style: TextStyle(fontSize: 14.0, color: Colors.black,)
              ),
            ),
            StreamMovesLeftCounter(),
          ],
        ),
      ),
    );
  }
}