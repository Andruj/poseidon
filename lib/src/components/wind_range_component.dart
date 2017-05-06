part of components;

@Component(
  selector: 'wind-range',
  styleUrls: const ['src/components/details_component.css'],
  templateUrl: 'src/components/wind_range_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class WindRangeComponent {
  final Logger log = new Logger("WindRangeComponent");


  final app.Firebase firebase;

  WindRangeComponent(this.firebase);
  @ViewChild('maxWind')
  ElementRef maxWindReference;

  @ViewChild('minWind')
  ElementRef minWindReference;

  @Input()
  app.Region region;

  @Output()
  final EventEmitter update = new EventEmitter();

  updateRegion() {
    update.add(null);
  }
}