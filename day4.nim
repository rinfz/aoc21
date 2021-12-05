import std/[strutils, sequtils, sugar, enumerate]

type
  Cell = object
    val: int
    flag: bool
  Board = seq[seq[Cell]]

proc mark(board: var Board; n: int) =
  for row in board.mitems:
    for cell in row.mitems:
      if cell.val == n:
        cell.flag = true

proc checkRowCol(row: seq[Cell]): bool =
  for cell in row:
    if not cell.flag: return false
  return true

proc checkRows(board: Board): bool =
  for row in board:
    if row.checkRowCol(): return true
  return false

proc checkCols(board: Board): bool =
  for i in 0..board[0].high:
    let col = collect(for r in board: r[i])
    if col.checkRowCol(): return true
  return false

proc sumUnmarked(board: Board): int =
  for row in board:
    for cell in row:
      if not cell.flag:
        result += cell.val

let
  data = readFile("input4.txt").split("\n\n")
  numbers = data[0].split(',').map(parseInt)
var
  boards = data[1..^1].map(proc(b: string): Board =
    b.strip(leading=false).split('\n').map(proc(l: string): seq[Cell] =
      l.splitWhitespace.map(x => Cell(val: x.parseInt, flag: false))
    )
  )

proc part1: int =
  for number in numbers:
    for board in boards.mitems:
      board.mark(number)
      if board.checkRows() or board.checkCols():
        return board.sumUnmarked() * number

proc part2: int =
  var boardIds = {0..boards.high}
  for number in numbers:
    for i, board in enumerate(boards.mitems):
      board.mark(number)
      if i in boardIds and (board.checkRows() or board.checkCols):
        if boardIds.len == 1:
          return board.sumUnmarked() * number
        boardIds.excl(i)
