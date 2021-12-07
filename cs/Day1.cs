using System;
using System.Collections.Generic;
using System.IO;

class Day1 {
  List<List<T>> windowed<T>(List<T> data, int size) {
    var result = new List<List<T>>((data.Count - size) + 1);
    for (int i = size-1; i < data.Count; ++i) {
      result.Add(data.GetRange(i-(size-1), size));
    }
    return result;
  }

  List<U> scan<T, U>(List<T> data, Func<T, T, U> fn) {
    var result = new List<U>(data.Count - 1);
    for (int i = 1; i < data.Count; ++i) {
      result.Add(fn(data[i-1], data[i]));
    }
    return result;
  }

  public void solve() {
    var data = File.ReadAllText("../input1.txt").Trim().Split('\n').Select(int.Parse).ToList();
    var result = scan<int, int>((
        from w in windowed(data, 3)
        select w[0] + w[1] + w[2]
    ).ToList(), ((a, b) => b > a ? 1 : 0)).Sum();
    Console.WriteLine(result);
  }
}
