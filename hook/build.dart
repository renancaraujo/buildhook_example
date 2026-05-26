import 'dart:io';

import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

const _packageName = 'buildhook_example';

void main(List<String> args) async {
  await build(args, (input, output) async {
    final logger = Logger('')
      ..level = Level.ALL
      ..onRecord.listen((record) => stderr.writeln(record));

    final sourceDir = input.packageRoot.resolve('src/');

    final builder = CMakeBuilder.create(
      name: _packageName,
      sourceDir: sourceDir,
      defines: {
        'CMAKE_BUILD_TYPE': 'Release',
        'CMAKE_INSTALL_PREFIX': '${input.outputDirectory.toFilePath()}/install',
      },
      targets: ['install'],
      buildLocal: true,
      logger: logger,
    );

    await builder.run(input: input, output: output, logger: logger);

    await output.findAndAddCodeAssets(
      input,
      names: {
        r'(lib)?buildhook_example\.(dll|so|dylib)': 'buildhook_example.dart',
      },
      outDir: input.outputDirectory.resolve('install'),
      logger: logger,
      regExp: true,
    );
  });
}
