import std/[sequtils, tables, sugar, strutils]

let data = "input3.txt".lines.toSeq

proc getCandidates(data: seq[string]; fn: proc): int =
    var candidates = data
    for i in 0..data[0].high:
        let counts = toCountTable(collect(for row in candidates: row[i]))
        candidates.keepItIf(it[i] == fn(counts))
        if candidates.len == 1: break
    return candidates[0].parseBinInt

proc getMax(counts: CountTable[char]): char =
    if counts['1'] >= counts['0']: '1' else: '0'

proc getMin(counts: CountTable[char]): char =
    if counts['0'] <= counts['1']: '0' else: '1'

echo getCandidates(data, getMax) * getCandidates(data, getMin)