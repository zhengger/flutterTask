/*
任务1：定义一个类Counter，为它设计合理的实例变量和方法，将实验三的代码重新组织成类的方式进行实现。
任务2：在任务1的基础上，定义类Counter两个派生类WordsCounter和CodeLineCounter，将实验三的代码重新组织进行实现，你也可以修改任务1Counter类的定义与实现方案。 */

import 'dart:io';

void main(List<String> args) async {
  /// https://itnext.io/learn-dart-5-read-and-write-files-in-under-30-seconds-9adbf9351ef2
  /// https://flutter.dev/docs/cookbook/persistence/reading-writing-files
  var myFile = new File(args[0]);
  // Counter.counterFunc(file: myFile, keywords: ["class", "this"]);
  WordCounter.counterFunc(file: myFile, keyword: "this");
}

class WordCounter extends Counter {
  File file;
  String keyword;
  WordCounter.counterFunc({this.file, this.keyword})
      : super(file: file, keywords: [keyword]) {
    super._counterFunc(file, keywords);
  }

  @override
  Future<dynamic> _counterFunc(File file, List<String> keywords) async {
    var wordCouterMap = {keywords[0]: 0};
    file.readAsLines().then((line) {
      for (var l in line) {
        // print("${line.indexOf(l)}.-------------------------------------------\n" + l);
        if (l.contains(keywords[0])) {
          wordCouterMap[keywords[0]]++;
        }
      }
      print(wordCouterMap);
      return wordCouterMap;
    });
  }
}

class Counter {
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
