import 'dart:math';

Point movePoint(Point point, Direction direction) {
  switch (direction) {
    case Direction.north:
      return Point(point.x, point.y - 1);
    case Direction.northEast:
      return Point(point.x + 1, point.y - 1);
    case Direction.east:
      return Point(point.x + 1, point.y);
    case Direction.southEast:
      return Point(point.x + 1, point.y + 1);
    case Direction.south:
      return Point(point.x, point.y + 1);
    case Direction.southWest:
      return Point(point.x - 1, point.y + 1);
    case Direction.west:
      return Point(point.x - 1, point.y);
    case Direction.northWest:
      return Point(point.x - 1, point.y - 1);
  }
}

enum Direction {
  north,
  northEast,
  east,
  southEast,
  south,
  southWest,
  west,
  northWest,
}
