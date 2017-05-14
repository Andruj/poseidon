part of components;

@Component(
  selector: 'overview',
  styleUrls: const ['src/components/overview_component.css'],
  templateUrl: 'src/components/overview_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class OverviewComponent implements OnInit {
  final Logger log = new Logger('OverviewComponent');

  final app.Firebase firebase;
  List<Map> cards = [];

  OverviewComponent(this.firebase);

  ngOnInit() {
    for (final app.Region region in firebase.regions.values) {
      List<DateTime> dates = region.watchlist.values
          .toList()
          .where((DateTime date) => date.isAfter(new DateTime.now())).toList();

      dates.sort();

      if(dates.isNotEmpty) {
        List<List<DateTime>> watchers = [];
        watchers.add([dates.first]);
        DateTime prev = dates.first;
        for (final DateTime date in dates.skip(1)) {
          if (date.difference(prev) == new Duration(hours: 3)) {
            watchers.last.add(date);
          } else {
            watchers.add([date]);
          }

          prev = date;
        }


        cards.addAll(watchers.map((wrappedDates) => { 'region': region,
            'dates': wrappedDates }));
      }

    }
  }
}
