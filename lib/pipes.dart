library pipes;

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';

part 'src/pipes/mph.dart';
part 'src/pipes/hour.dart';

const appPipes = const [UnitPipe, HourPipe];