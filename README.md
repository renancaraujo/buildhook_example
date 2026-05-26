# buildhook_example

A minimal Dart library that calls a native C++ `sum(int32_t, int32_t)` function.
The C++ source is compiled into a shared library by a `hook/build.dart`
[Dart build hook](https://dart.dev/tools/hooks) using
[`native_toolchain_cmake`](https://pub.dev/packages/native_toolchain_cmake),
then exposed to Dart via FFI as a [code asset](https://pub.dev/packages/code_assets).

A runnable consumer lives under [example/](example/) — a separate package that
depends on the library via a local path and calls `sum` from a Dart script.

## Layout

```
buildhook_example/
├── lib/buildhook_example.dart        # @Native FFI binding to `sum`
├── hook/build.dart                   # build hook: runs CMake, registers code asset
├── src/
│   ├── buildhook_example.cpp         # extern "C" int32_t sum(int32_t, int32_t)
│   ├── common.h                      # EXPORT visibility macro
│   └── CMakeLists.txt                # builds + installs libbuildhook_example
└── example/                          # consumer package (own pubspec)
    ├── pubspec.yaml                  # depends on buildhook_example via path: ../
    └── bin/buildhook_example.dart    # example script using `sum`
```

## Prerequisites

- Dart SDK 3.12 or later
- CMake 3.15+ on `PATH` (e.g. `brew install cmake` on macOS)
- A C++ toolchain (Xcode Command Line Tools on macOS, MSVC on Windows, GCC/Clang on Linux)

## Run the example

```sh
git clone https://github.com/renancaraujo/buildhook_example.git
cd buildhook_example/example
dart pub get
dart run bin/buildhook_example.dart 2 3   # → 5
dart run bin/buildhook_example.dart 40 2  # → 42
```

The first invocation runs `hook/build.dart`, which calls CMake to compile
`libbuildhook_example.dylib` (or `.so` / `.dll`) into
`.dart_tool/hooks_runner/…`. Subsequent runs are cached.
