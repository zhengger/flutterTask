import 'dart:io';

void main(List<String> args) async {
  /// https://itnext.io/learn-dart-5-read-and-write-files-in-under-30-seconds-9adbf9351ef2
  /// https://flutter.dev/docs/cookbook/persistence/reading-writing-files
  var myFile = new File(args[0]);
  counterFunc(myFile, ["class", "this"]);
}

Future<dynamic> counterFunc(File file, List<String> keywords) async {
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
