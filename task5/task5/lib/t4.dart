/* 为之前的实验四的类和方法增加注释，并生成HTML文档。

挑战：定义一个泛型方法，实现统计Words和CodeLine个数的通用方法。 */

import 'dart:io';

// void main(List<String> args) async {
//   var myFile = new File(args[0]);
//   // Counter.counterFunc(file: myFile, keywords: ["class", "this"]);
//   WordsCounter.counterFunc(file: myFile, keyword: "this");
//   CodeLineCounter.counterFunc(file: myFile);
// }

class CodeLineCounter extends Counter {
  /// 计算行数
  int _lines = 0;
  Future<Map<String, int>> _counterFunc(
      File file, List<String> keywords) async {
    file.readAsLines().then((lines) {
      _lines = lines.length;
      print("lines: $_lines");
    });
    return {"lines": _lines};
  }

  CodeLineCounter.counterFunc({File file}) {
    _counterFunc(file, null);
  }
}

class WordsCounter extends Counter {
  /// 计算某个单词(Stirng)的出现次数
  File file;
  String keyword;
  WordsCounter.counterFunc({this.file, this.keyword})
      : super(file: file, keywords: [keyword, "DON'T SEE ME:)"]) {
    super._counterFunc(file, keywords);
  }
}

class Counter {
  ///基础类
  File file;
  List<String> keywords;
  Counter({this.file, this.keywords});
  Counter.counterFunc({this.file, this.keywords}) {
    _counterFunc(file, keywords);
  }

  Future<dynamic> _counterFunc(File file, List<String> keywords) async {
    var wordCouterMap = {keywords[0]: 0, keywords[1]: 0};
    file.readAsLines().then((line) {
      for (var l in line) {
        // print("${line.indexOf(l)}.-------------------------------------------\n" + l);
        if (l.contains(keywords[0])) {
          wordCouterMap[keywords[0]]++;
        }
        if (l.contains(keywords[1])) {
          wordCouterMap[keywords[1]]++;
        }
      }
      print(wordCouterMap);
      return wordCouterMap;
    });
  }
}
