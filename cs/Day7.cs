using System;
using System.IO;
using System.Collections.Generic;

class Day7 {
  (T?, T?) MinMax<T>(IEnumerable<T> elems) {
    return (elems.Min(), elems.Max());
  }

  public void solve() {
    var data = File.ReadAllText("../input7.txt").Trim().Split(',').Select(long.Parse);
    var (l, h) = MinMax(data);
    long minFuel = 999_999_999;
    for (long i = l; i <= h; ++i) {
      long fuel = 0;
      foreach (var crab in data) {
        for (long step = 1; step <= Math.Abs(crab-i); ++step) {
          fuel += step;
        }
      }
      minFuel = Math.Min(fuel, minFuel);
    }
    Console.WriteLine(minFuel);
  }
}
