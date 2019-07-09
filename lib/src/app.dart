import 'package:flutter/material.dart';

import 'data/blocs/game_bloc.dart';
import 'data/providers/bloc_provider.dart';
import 'pages/home_page.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider<GameBloc>(
      bloc: GameBloc(),
      child: MaterialApp(
        title: 'Crush Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: HomePage(),
      ),
    );
  }
}
