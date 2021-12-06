import std/[strutils, sequtils, sugar, tables, math]

proc nextDay(current: CountTable[int]): CountTable[int] =
    for k, v in current.pairs:
        if k == 0:
            result.inc 6, v
            result.inc 8, v
        else:
            result.inc k-1, v

var data = readFile("input6.txt").strip(leading=false).split(',').map(parseInt).toCountTable
for _ in 1..256: data = data.nextDay
echo sum(data.values.toSeq)