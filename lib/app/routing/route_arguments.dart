class RouteArguments<T> {
  final T data;

  RouteArguments(this.data)
      : assert(
          T != dynamic,
          'T must be a valid type to RouteArguments<T>.',
        );

  @override
  String toString() => 'RouteArguments(data: $data)';
}
