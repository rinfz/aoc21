using System;
using System.IO;
using System.Collections.Generic;

class Day8 {
  int Check5(string n, string one, string four) {
    if (n.Intersect(one).ToArray().Length == 2) {
      return 3;
    } else if (n.Intersect(four).ToArray().Length == 2) {
      return 2;
    } else {
      return 5;
    }
  }

  int Check6(string n, string one, string four) {
    if (n.Intersect(one).ToArray().Length == 1) {
      return 6;
    } else if (n.Intersect(four).ToArray().Length == 3) {
      return 0;
    } else {
      return 9;
    }
  }

  public void Solve() {
    var data = File.ReadAllLines("../input8.txt").ToList().Select(line => {
      var parts = line.Split(" | ");
      return (parts[0].Split(' ').ToList(), parts[1].Split(' ').ToList());
    });

    var result = 0;
    var mult = new List<int> {1000, 100, 10, 1};

    foreach (var (input, output) in data) {
      var one = input.Find(x => x.Length == 2) ?? "";
      var four = input.Find(x => x.Length == 4) ?? "";

      var sum = 0;
      foreach (var (num, m) in output.Zip(mult)) {
        sum += m * num.Length switch {
          2 => 1,
          3 => 7,
          4 => 4,
          5 => Check5(num, one, four),
          6 => Check6(num, one, four),
          7 => 8,
          _ => 0,
        };
      }

      result += sum;
    }

    Console.WriteLine(result);
  }
}