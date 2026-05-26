import 'dart:io';

import 'package:buildhook_example/buildhook_example.dart' as native;

void main(List<String> args) {
  if (args.length != 2) {
    stderr.writeln('Usage: buildhook_example <a> <b>');
    exit(64);
  }

  final a = int.tryParse(args[0]);
  final b = int.tryParse(args[1]);
  if (a == null || b == null) {
    stderr.writeln('Both arguments must be integers.');
    exit(64);
  }

  print(native.sum(a, b));
}
