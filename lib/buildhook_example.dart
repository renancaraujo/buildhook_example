@DefaultAsset('package:buildhook_example/buildhook_example.dart')
library;

import 'dart:ffi';

@Native<Int32 Function(Int32, Int32)>(symbol: 'sum')
external int sum(int a, int b);
