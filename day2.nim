import std/[sequtils, strscans]

var
    depth = 0
    hpos = 0
    aim = 0

let data = "input2.txt".lines.toSeq

proc part1 =
    var cmd: string
    var delta: int

    for line in data:
        if scanf(line, "$w $i", cmd, delta):
            case cmd
            of "forward": hpos += delta
            of "up": depth -= delta
            of "down": depth += delta
            else: doAssert(false, "Unknown command: " & cmd)

    echo depth * hpos

proc part2 =
    var cmd: string
    var delta: int
    for line in data:
        if scanf(line, "$w $i", cmd, delta):
            case cmd
            of "forward":
                hpos += delta
                depth += aim * delta
            of "up":
                aim -= delta
            of "down":
                aim += delta
            else: doAssert(false, "Unknown command: " & cmd)
    echo depth * hpos

part2()