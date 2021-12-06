import std/[strutils, sequtils, math]

proc windowed[T](arr: openArray[T]; n: int): seq[seq[T]] =
    result = newSeqOfCap[seq[T]]((arr.len - n) + 1)
    for i in (n-1)..arr.high:
        result.add(arr[i-(n-1) .. i])

proc scan[T, U](arr: openArray[T]; fn: proc(a,b: T): U): seq[U] =
    if arr.len == 0: return @[]
    result = newSeqOfCap[T](arr.len-1)
    for i in 1..arr.high:
        result.add(fn(arr[i-1], arr[i]))

proc sum1[T](arr: seq[T]): T = arr.sum
proc cmp(a, b: int): int = int(b > a)

let data = "input1.txt".lines.toSeq.map(parseInt)

echo data.scan(cmp).sum
echo data.windowed(3).map(sum1).scan(cmp).sum