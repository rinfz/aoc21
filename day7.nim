import std/[strutils, strscans, sequtils, sugar]

proc minmax[T](arr: openArray[T]): (T, T) =
    return (arr.min, arr.max)

proc solve(data: seq[int]): int =
    let (l, h) = minmax(data)
    var minFuel = 999_999_999
    for i in l..h:
        var fuel = 0
        for crab in data:
            for step in 1..abs(crab-i):
                fuel += step
        minFuel = min(fuel, minFuel)
    return minFuel

let data = readFile("input7.txt").strip(leading=false).split(',').map(parseInt)
echo data.solve