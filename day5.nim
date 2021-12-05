import std/[strscans, sequtils, sugar]

type
  Point = object
    x, y: int
  Line = object
    p1, p2: Point

proc isH(line: Line): bool = line.p1.y == line.p2.y
proc isV(line: Line): bool = line.p1.x == line.p2.x

var w, h = -1

proc minmax[T](a, b: T): (T, T) =
  if a < b: (a, b) else: (b, a)

proc parseLines: seq[Line] =
  for line in lines("input5.txt"):
    let (_, x1, y1, x2, y2) = scanTuple(line, "$i,$i -> $i,$i")
    w = max(w, max(x1, x2))
    h = max(h, max(y1, y2))
    result.add Line(p1: Point(x: x1, y: y1), p2: Point(x: x2, y: y2))

proc findOverlaps(grid: seq[seq[int]]): int =
  for row in grid:
    for col in row:
      if col > 1:
        inc result

proc solve(data: seq[Line]): int =
  var grid = toSeq(0..h).map(_ => toSeq(0..w).map(_ => 0))
  for line in data:
    let
      (lx, hx) = minmax(line.p1.x, line.p2.x)
      (ly, hy) = minmax(line.p1.y, line.p2.y)
    if line.isH:
      for x in lx..hx: inc grid[line.p1.y][x]
    elif line.isV:
      for y in ly..hy: inc grid[y][line.p1.x]
    else: # part 2
      var y = if lx == line.p1.x: line.p1.y else: line.p2.y
      let delta = if ly == y: 1 else: -1
      for x in lx..hx:
        inc grid[y][x]
        y += delta
  findOverlaps grid

let data = parseLines()
echo solve(data)
