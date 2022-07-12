class GridState {
  final bool? isGrid;

  GridState({this.isGrid});

  GridState copyWith({bool? isGrid}) {
    return GridState(isGrid: isGrid ?? this.isGrid);
  }
  static get empty =>  GridState();
}
