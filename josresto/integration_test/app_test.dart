import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:josresto/data/model/restaurant_list_response.dart';
import 'package:josresto/main.dart';
import 'package:josresto/provider/nav_provider.dart';
import 'package:josresto/provider/restaurant_list_provider.dart';
import 'package:josresto/provider/setting_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../test/api_service_mock.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockApiService mockApiService;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    mockApiService = MockApiService();
    restaurantListProvider = RestaurantListProvider(mockApiService);

    registerFallbackValue(RestaurantListResponse(
      error: false,
      message: "Success",
      count: 0,
      restaurants: [],
    ));
  });
  testWidgets("Aplikasi dapat dibuka dengan baik", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider<RestaurantListProvider>.value(
            value: restaurantListProvider),
        ChangeNotifierProvider(create: (context) => SettingProvider()),
      ],
      child: const MyApp(),
    ));

    expect(find.text("JosResto"), findsOneWidget);
  });
}
