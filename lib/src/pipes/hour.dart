part of pipes;

@Pipe(name: "hour")
class HourPipe extends PipeTransform {
  final Logger log = new Logger('HourPipe');

  String transform(val) => val < 10 ? '0$val' : '$val';
}
