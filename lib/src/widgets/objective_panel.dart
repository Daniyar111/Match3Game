import 'package:flutter/material.dart';
import 'package:match3_game/src/data/blocs/game_bloc.dart';
import 'package:match3_game/src/data/providers/bloc_provider.dart';
import 'package:match3_game/src/models/level.dart';
import 'package:match3_game/src/models/objective.dart';

import 'stream_objective_item.dart';

class ObjectivePanel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final GameBloc gameBloc = BlocProvider.of<GameBloc>(context);

    final Level level = gameBloc.gameController.level;

    final Orientation orientation = MediaQuery.of(context).orientation;

    final EdgeInsets paddingTop = EdgeInsets.only(top: (orientation == Orientation.portrait ? 10.0 : 0.0));

    //
    // Build the objectives
    //
    List<Widget> objectiveWidgets = level.objectives.map((Objective obj){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: StreamObjectiveItem(objective: obj),
      );
    }).toList();

    return Padding(
      padding: paddingTop,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300].withOpacity(0.7),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 5.0, color: Colors.black.withOpacity(0.5)),
        ),
        height: 80.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: objectiveWidgets,
        ),
      ),
    );
  }
}