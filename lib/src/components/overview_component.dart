part of components;

@Component(
  selector: 'overview',
  styleUrls: const ['src/components/overview_component.css'],
  templateUrl: 'src/components/overview_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class OverviewComponent {}
