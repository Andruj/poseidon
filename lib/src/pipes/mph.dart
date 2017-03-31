part of pipes;

class Unit {
  static const mph = 'mph';
  static const kmh = 'kmh';
  static const kts = 'kts';
}

@Pipe(name: "units")
class UnitPipe extends PipeTransform {
  final Logger log = new Logger('UnitPipe');

  static const num toMph = 2.23694;
  static const truncate = 0;

  String transform(val, String units) {
    if(Unit.mph == units) {
      num mph = val * toMph;
      return '${mph.round().toStringAsFixed(truncate)}';
    }

    return '';
  }
}