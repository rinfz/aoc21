using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;

class Day9 {
    private HashSet<(int,int)> seen;

    public Day9() {
        seen = new HashSet<(int, int)>();
    }

    int FindBasin(List<List<int>> data, int cmp, int x, int y, int dx, int dy) {
        if (seen.Contains((x, y))) return 0;
        if (y < 0 || y >= data.Count) return 0;
        if (x < 0 || x >= data[y].Count) return 0;
        if (data[y][x] == 9 || data[y][x] <= cmp) {
            return 0;
        } else {
            seen.Add((x, y));
            return 1 + FindBasin(data, data[y][x], x, y+1, 0, 1) +
                        FindBasin(data, data[y][x], x, y-1, 0, -1) +
                        FindBasin(data, data[y][x], x+1, y, 1, 0) +
                        FindBasin(data, data[y][x], x-1, y, -1, 0);
        }
    }

    public void Solve() {
        var data = File.ReadAllLines("../input9.txt")
            .Select((string line) => line.ToArray().Select(x => int.Parse(x.ToString())).ToList()).ToList();
        var part1 = 0;
        List<int> basins = new();

        for (int y = 0; y < data.Count; ++y) {
            for (int x = 0; x < data[y].Count; ++x) {
                var points = new List<int>();
                if (y - 1 >= 0) points.Add(data[y-1][x]);
                if (y + 1 < data.Count) points.Add(data[y+1][x]);
                if (x - 1 >= 0) points.Add(data[y][x-1]);
                if (x + 1 < data[y].Count) points.Add(data[y][x+1]);
                if (points.All(p => p > data[y][x])) {
                    // low point
                    part1 += data[y][x] + 1;
                    basins.Add(
                        1 + 
                        FindBasin(data, data[y][x], x, y+1, 0, 1) +
                        FindBasin(data, data[y][x], x, y-1, 0, -1) +
                        FindBasin(data, data[y][x], x+1, y, 1, 0) +
                        FindBasin(data, data[y][x], x-1, y, -1, 0)
                    );
                }
            }
        }
        Console.WriteLine(part1);
        basins.Sort();
        basins.Reverse();
        Console.WriteLine(basins[0] * basins[1] * basins[2]);
    }
}