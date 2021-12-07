using System;
using System.IO;
using System.Collections.Generic;

class Day2 {
  public void solve() {
    int pos = 0;
    int depth = 0;
    int aim = 0;

    var data = File.ReadAllText("../input2.txt").Trim().Split('\n').Select(line => {
        var parts = line.Split(' ');
        return (parts[0], int.Parse(parts[1]));
    });

    foreach (var (cmd, delta) in data) {
      switch (cmd) {
        case "forward":
          pos += delta;
          depth += aim * delta;
          break;
        case "down":
          aim += delta;
          break;
        case "up":
          aim -= delta;
          break;
      };
    }

    Console.WriteLine(pos * depth);
  }
}
