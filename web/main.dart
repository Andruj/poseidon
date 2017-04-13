// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/platform/browser.dart';
import 'package:logging/logging.dart';

import 'package:poseidon/components.dart';

main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.loggerName}:${rec.level.name} - ${rec.message}');
  });

  bootstrap(rootComponent);
}
