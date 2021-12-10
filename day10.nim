import std/[strutils, sequtils, sugar, tables, algorithm, math]

let
  opening = {'(', '[', '{', '<'}
  closing = {')': '(', ']': '[', '}': '{', '>': '<'}.toTable()
  scores = {')': 3, ']': 57, '}': 1197, '>': 25137}.toTable()
  scores2 = {'(': 1, '[': 2, '{': 3, '<': 4}.toTable()

var result = 0
var part2 = newSeq[int]()

for line in "input10.txt".lines:
  var stack = newSeq[char]()
  var corrupted = false

  for c in line:
    if c in opening:
      stack.add c
    elif closing[c] == stack.pop():
      continue
    else:
      result += scores[c]
      corrupted = true
      break

  if not corrupted:
    var total = 0
    for c in stack.reversed:
      total *= 5
      total += scores2[c]
    part2.add total

echo result
echo part2.sorted[int(floor(part2.len / 2))]