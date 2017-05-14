part of components;

@Component(
  selector: 'watch-card',
  styleUrls: const ['src/components/watch_card_component.css'],
  templateUrl: 'src/components/watch_card_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class WatchCardComponent implements OnInit {
  final Logger log = new Logger('WatchCardComponent');

  @Input()
  app.Region region;

  @Input()
  List<DateTime> dates;

  ngOnInit() {
    log.info(region);
  }

  String get title {
    DateTime first = dates.first;
    DateTime last = dates.last;


    return '${first.hour} - ${last.hour}, ${first.month}.${first.day}';
  }

}
