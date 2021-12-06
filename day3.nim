import std/[enumerate, strutils, sequtils, sugar]

const l = 5
const file = "sample.txt"

var data: array[l, string]

for line in file.lines:
    for i, c in enumerate(line):
        data[i] &= c

var gamma = ""
var epsilon = ""

for col in data:
    let ct1 = col.count('1')
    let ct2 = col.count('0')
    if ct1 > ct2:
        gamma &= '1'
        epsilon &= '0'
    else:
        gamma &= '0'
        epsilon &= '1'

echo gamma.parseBinInt * epsilon.parseBinInt