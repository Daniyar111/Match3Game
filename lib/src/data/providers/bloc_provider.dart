import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

abstract class BlocBase{

  void dispose();
}


class BlocProvider<T extends BlocBase> extends StatefulWidget {

  final Widget child;
  final T bloc;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc
  }) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();


  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider = context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }
}


class _BlocProviderInherited<T> extends InheritedWidget {

  final T bloc;

  const _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc
  })
      : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProviderInherited old) {
    return true;
  }
}



///  Rather than writing:
///
///   BlocProvider<A>(
///     bloc: A(),
///     child: BlocProvider<B>(
///       bloc: B(),
///       child: BlocProvider<C>(
///         bloc: C(),
///         child: Container(),
///       ),
///     ),
///   )
///
///  We can write:
///
///   blocsTree(
///     [
///       blocTreeNode<A>(A()),
///       blocTreeNode<B>(B()),
///       blocTreeNode<C>(C()),
///     ],
///     child: Container(),
///   ),
///
///   This is much easier to read and to complement.


//typedef BlocProvider _BuildWithChild(Widget child);
//
//Widget blocsTree(List<_BuildWithChild> childlessBlocs, {@required Widget child}){
//  return childlessBlocs.reversed.fold<Widget>(child, combine)
//}