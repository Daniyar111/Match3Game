import 'tile_type.dart';

/// Objective
///
/// One objective for a level

class Objective extends Object{

  TileType type;
  int count = 0;
  int initialValue = 0;
  bool completed = false;

  Objective(String string){

    List<String> parts = string.split(';');

    // Retrieve the type by its name (as a String)
    type = TileType.values.firstWhere((e) => e.toString().split('.')[1] == parts[1]);
//    print('Objective class type $type');
    initialValue = int.parse(parts[0]);

    reset();
  }


  @override
  bool operator ==(other) {
    return identical(this, other) || this.type == other.type;
  }

  @override
  int get hashCode => type.index;


  // Decrements the number of times this objective needs to be met.
  // Once the objective has been reached, sets it to 'completed'.

  void decrement(int value){
    count -= value;
    if(count <= 0){
      completed = true;
      count = 0;
    }
  }


  // Reset of the counter of the objective at start of a new game

  void reset(){
    count = initialValue;
  }

}